import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/elasticsearch/elasticsearch.dart';
import 'package:inked/utils/filters/utils.dart';

const MIN_SCORE = 6.3;
class TermsFilterProcessor {
  TermsFilterProcessor(this.news, this.filters);

  final News news;
  final List<TermsFilter> filters;
  var _host = DotEnv().env["ES_HOST"];
  List<NewsFilterResult> allMatched = [];
  NewsFilterResult highestMatched;

  process() async {
    // es search
    var es = Elasticsearch(_host.toString());
    if (filters.length > 0) {
      for (var temFilter in filters) {
        var term = temFilter.terms;
        var res = await es.documentMatches(news.id, term);
        if (res != null) {
          if (res.documents.first.score > MIN_SCORE){
            allMatched.add(NewsFilterResult(true,
                action: temFilter.action,
                highlights: res.documents.first.highlight,
                score: res.documents.first.score,
                maxScore: res.maxScore,
                terms: term));
          }
        }
      }
      highestMatched = getHighestNewsFilterResult(allMatched);
    }
    return highestMatched;
  }
}
