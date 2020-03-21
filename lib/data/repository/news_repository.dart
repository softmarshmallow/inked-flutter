import 'package:inked/data/model/news.dart';
const MAX_NEWS_MEMORY_COUNT = 1000;

class NewsRepository{
  static List<News> NEWS_LIST = [];
  static addNews(News newsItem){
    NEWS_LIST.insert(0, newsItem);
    if (NEWS_LIST.length > MAX_NEWS_MEMORY_COUNT) {
      NEWS_LIST.removeRange(0, NEWS_LIST.length - MAX_NEWS_MEMORY_COUNT);
    }
    print('new item has added to repository : $newsItem');
  }

  static get latestNews => NEWS_LIST.first;
}