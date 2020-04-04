import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/constants.dart';
import 'package:inked/utils/elasticsearch/elasticsearch.dart';

const MAX_NEWS_MEMORY_COUNT = 1000;

class NewsRepository {
  static List<News> NEWS_LIST = [];

  static bool addNews(News newsItem) {
    try {
      var conflictIndex = NEWS_LIST.indexWhere((element) =>
      element.id == newsItem.id);
      NEWS_LIST.removeAt(conflictIndex);
      NEWS_LIST.insert(conflictIndex, newsItem);
      return true;
    } catch (e) {}

    NEWS_LIST.insert(0, newsItem);
    onAdd(newsItem);
    if (NEWS_LIST.length > MAX_NEWS_MEMORY_COUNT) {
      NEWS_LIST.removeRange(0, NEWS_LIST.length - MAX_NEWS_MEMORY_COUNT);
    }
    print('new item has added to repository : $newsItem');
    return true;
  }


  static onAdd(News news) async {
    var host =  DotEnv().env["ES_HOST"];
    var es = Elasticsearch(host.toString());
    var res = await es.documentMatches(news.id, "속보");
    print(res);
    if (res) {
      AudioPlayer audioPlayer = AudioPlayer();
      var res = await audioPlayer.play(
          SOUND_TONE_2_URL);
      print(res);
    }
  }

  static get latestNews => NEWS_LIST.first;
}