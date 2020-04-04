import 'package:dio/dio.dart';
import 'package:inked/utils/elasticsearch/model.dart';

class Elasticsearch {
  final String _host;
  Dio dio;

  Elasticsearch(this._host) {
    print("host is $_host");
    BaseOptions options = new BaseOptions(
      baseUrl: _host,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = new Dio(options);
  }

  Future<SearchResponse<NewsDocumentResult>> searchMultiMatch(String term,
      {int size = 20, int page = 1}) async {
    int from = (page - 1) * size;
    try {
      var q = {
        "query": {
          "bool": {
            "must": [
              {
                "multi_match": {
                  "query": term,
                  "fields": ["content", "title"]
                }
              }
            ],
            "filter": [
              {
                "range": {
                  "time": {"gte": "now-1d"}
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
          "fields": {"content": {}}
        },
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
      return false;
    }
  }

  Future<SearchResponse<NewsDocumentResult>> searchInSingleDocument(
      String doc, String term) async {
    var q = {
      "query": {
        "bool": {
          "must": [
            {
              "multi_match": {
                "query": term,
                "fields": ["content", "title"]
              }
            }
          ],
          "filter": {
            "ids": {
              "values": [doc]
            }
          }
        }
      }
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

  Future<bool> documentMatches(String doc, String term) async {
    try{
      var res = await searchInSingleDocument(doc, term);
      return res.documents.length > 0;
    }catch(e){
      return false;
    }
  }
}


SearchResponse buildSearchResponse(dynamic data){
  var hitsObj = data["hits"];
  var maxScore = hitsObj["max_score"];
  var took = data["took"];
  var timedOut = data["timed_out"];
  var totalHistCount = hitsObj["total"]["value"];

  return SearchResponse<NewsDocumentResult>(
      maxScore: maxScore,
      took: took,
      total: totalHistCount,
      timedOut: timedOut,);
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