import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/repository/base.dart';
import 'package:inked/data/repository/news_filter_repositry.dart';
import 'package:inked/utils/filters/terms_filter_processor.dart';

const MAX_NEWS_MEMORY_COUNT = 1000;

class NewsRepository extends BaseRepository<News> {
  // region singleton
  static final NewsRepository _singleton = NewsRepository._internal();

  factory NewsRepository() {
    return _singleton;
  }

  NewsRepository._internal();

  // endregion

  var excludePublisher = ["부산일보", "국민일보", "서울신문"];
  bool add(News newsItem) {
    // quick fix todo -> migrate
    if (excludePublisher.contains(newsItem.provider)) {
      return false;
    }

    var replaced = replace(newsItem);
    if (replaced) {
      onAdd(newsItem);
      return true;
    }

    DATA.insert(0, newsItem);
    onAdd(newsItem);
    if (DATA.length > MAX_NEWS_MEMORY_COUNT) {
      DATA.removeRange(0, DATA.length - MAX_NEWS_MEMORY_COUNT);
    }
    print('new item has added to repository : $newsItem');
    return true;
  }

  @override
  set(List<News> data) {
    // TODO: implement set
    throw UnimplementedError();
  }

  bool replace(News news){
    try {
      var conflictIndex =
      DATA.indexWhere((element) => element.id == news.id);
      DATA.removeAt(conflictIndex);
      DATA.insert(conflictIndex, news);
      return true;
    } catch (e) {
      return false;
    }
  }

  NewsFilterRepository newsFilterRepository = NewsFilterRepository();

  onAdd(News news) async {
    // convert meta spam to spam
    if (news.meta.isSpam) {
      news.filterResult = NewsFilterResult(
        true,
        action: FilterAction.HIDE,
      );
    }
    onReplaced(news);
    onNewsUpdated?.call(news);
  }

  onReplaced(News news) async {

    if (news.meta.isSpam) {
      print("skipping due to spam.. ${news.title}");
      return;
    }

    // es filter
    var processor = TermsFilterProcessor(news, newsFilterRepository.DATA);
    await processor.process();
    if (processor.highestMatched != null){
      news.filterResult = processor.highestMatched;
      replace(news);
      onNewsUpdated?.call(news);
    }
  }

  Function(News news) onNewsUpdated;

  get latestNews => DATA.first;
}
