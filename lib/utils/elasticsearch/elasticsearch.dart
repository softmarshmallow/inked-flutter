import 'package:dio/dio.dart';
import 'package:inked/utils/elasticsearch/model.dart';
import 'dart:developer' as developer;

class Elasticsearch {
  final String _host;
  Dio dio;

  Elasticsearch(this._host) {
//    print("host is $_host");
    BaseOptions options = new BaseOptions(
      baseUrl: _host,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = new Dio(options);
  }

  Future<SearchResponse<NewsDocumentResult>> searchMultiMatch(String term,
      {int size = 20, int page = 1, DateTime timeFrom, DateTime timeTo}) async {
    int from = (page - 1) * size;
    try {
      var q = {
        "query": {
          "bool": {
            "must": [
              {
                "simple_query_string": {
                  "query": term,
                  "fields": ["title", "content"]
                }
              }
            ],
            "filter": [
              {
                "range": {
                  "time": {"gte": timeFrom?.toIso8601String(), "lte": timeTo?.toIso8601String()}
                }
              },
              {
                "nested": {
                  "path": "meta",
                  "query": {
                    "match": {"meta.isSpam": false}
                  }
                }
              }
            ]
          }
        },
        "highlight": {
          "fields": {"content": {}, "title": {}}
        },
        "sort" : [
          { "time" : {"order" : "desc"}},
          "_score"
        ],
        "size": size,
        "from": from
      };

      Response response = await dio.post("/news/_search", data: q);
      var searchRes = buildSearchResponse(response.data);
      var hitsArray = response.data["hits"]["hits"];
      List<NewsDocumentResult> res = [];
      for (var h in hitsArray) {
        var docRes = NewsDocumentResult.fromJson(h);
        docRes.source.id = docRes.id;
        res.add(docRes);
      }
      searchRes.documents = res;
      return searchRes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> documentExists(String id) async {
    try {
      var res = await dio.head("/news/_doc/$id");
      return res.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<SearchResponse<NewsDocumentResult>> searchInSingleDocument(
      String doc, String term,
      {bool matchPhrase = false}) async {
    var matchPhraseQuery = {
      "multi_match": {
        "query": term,
        "type": "phrase",
        "fields": ["title", "content"]
      }
    };

    var simpleQuery = {
      "simple_query_string": {
        "query": term,
        "fields": ["title", "content"]
      }
    };

    var query;
    if (matchPhrase) {
      query = matchPhraseQuery;
    } else {
      query = simpleQuery;
    }

    var q = {
      "query": {
        "bool": {
          "must": [query],
          "filter": {
            "ids": {
              "values": [doc]
            }
          }
        }
      },
      "highlight": {
        "fields": {"content": {}, "title": {}}
      },
    };
    Response response = await dio.post("/news/_search", data: q);
    var searchRes = buildSearchResponse(response.data);
    var hitsArray = response.data["hits"]["hits"];
    List<NewsDocumentResult> res = [];
    for (var h in hitsArray) {
      var docRes = NewsDocumentResult.fromJson(h);
      docRes.source.id = docRes.id;
      res.add(docRes);
    }
    searchRes.documents = res;
    return searchRes;
  }

  Future<SearchResponse<NewsDocumentResult>> documentMatches(String doc, String term) async {
    try {
      var exists = await documentExists(doc);
      if (!exists) {
        print("document is not ready to search $doc");
        return null;
      }
      var res = await searchInSingleDocument(doc, term);
      var matched = res.documents.length > 0;
//      print("doc: $doc matched: $matched for score ${res.maxScore}for term: $term");
      if (matched) {
        return res;
      }  else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

SearchResponse buildSearchResponse(dynamic data) {
  var hitsObj = data["hits"];
  var maxScore = hitsObj["max_score"];
  var took = data["took"];
  var timedOut = data["timed_out"];
  var totalHistCount = hitsObj["total"]["value"];

  return SearchResponse<NewsDocumentResult>(
    maxScore: maxScore,
    took: took,
    total: totalHistCount,
    timedOut: timedOut,
  );
}

/*
* {
"query": {
  "simple_query_string": {
    "query": "코로나 -포토 -사진",
    "fields": ["title", "content"]
  }
}
}*/
