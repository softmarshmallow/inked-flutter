import 'package:dio/dio.dart';
import 'package:inked/utils/elasticsearch/model.dart';

class Elasticsearch {
  final String _host;
  Dio dio;

  Elasticsearch(this._host) {
    BaseOptions options = new BaseOptions(
      baseUrl: _host,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = new Dio(options);
  }

  Future<List<NewsDocumentResult>> searchMultiMatch(String term,
      {int size = 20, int from = 0}) async {
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
      var hitsObj = response.data["hits"];
      var hitsArray = hitsObj["hits"];
      List<NewsDocumentResult> res = [];
      for (var h in hitsArray) {
        var docRes = NewsDocumentResult.fromJson(h);
        docRes.source.id = docRes.id;
        res.add(docRes);
      }
      return res;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
