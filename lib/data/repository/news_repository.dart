import 'package:inked/data/model/news.dart';
const MAX_NEWS_MEMORY_COUNT = 1000;

class NewsRepository{
  static List<News> NEWS_LIST = [];
  static bool addNews(News newsItem){
    try{
      var conflictIndex = NEWS_LIST.indexWhere((element) => element.id == newsItem.id);
      NEWS_LIST.removeAt(conflictIndex);
      NEWS_LIST.insert(conflictIndex, newsItem);
//      conflictIndex.meta = newsItem.meta;
      print("replaced news");
      return true;
    }catch(e){}

    NEWS_LIST.insert(0, newsItem);
    if (NEWS_LIST.length > MAX_NEWS_MEMORY_COUNT) {
      NEWS_LIST.removeRange(0, NEWS_LIST.length - MAX_NEWS_MEMORY_COUNT);
    }
    print('new item has added to repository : $newsItem');
    return true;
  }

  static get latestNews => NEWS_LIST.first;
}