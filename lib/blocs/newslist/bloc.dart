import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/data/local/mock/mock_filter_db.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/realtime_news_receiver.dart';
import 'package:inked/data/repository/news_repository.dart';
import 'package:inked/utils/token_filter_processor.dart';

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object> get props => [];
}

class NewsFocusEvent extends NewsListEvent {
  const NewsFocusEvent(this.news);

  final News news;
}

class TopFocusEvent extends NewsListEvent {
  const TopFocusEvent();
}

class NewNewsEvent extends NewsListEvent {
  const NewNewsEvent(this.news);

  final News news;
}

abstract class NewsListState extends Equatable {
  const NewsListState(this.news, this.newses);

  final News news;
  final List<News> newses;

  @override
  List<Object> get props => [news];
}

class NoFocusState extends NewsListState {
  NoFocusState() : super(null, []);
}

class FocusedState extends NewsListState {
  FocusedState(News news) : super(news, NewsRepository.NEWS_LIST);
}

class FocusedStillState extends FocusedState{
  FocusedStillState(News news, this.newNews) : super(news);
  final News newNews;

  @override
  List<Object> get props => [news, newNews];
}

class TopFocusState extends NewsListState {
  TopFocusState(News news) : super(news, NewsRepository.NEWS_LIST);
}

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  @override
  NewsListState get initialState => NoFocusState();

  NewsItemFocusType _focusType = NewsItemFocusType.TopFocus;
  News _focusedNews;

  NewsListBloc() {
    RealtimeNewsReceiver().steam().listen((news) {
//      _runFilters(news);
      var isAdded = NewsRepository.addNews(news);
      if (isAdded) {
        add(NewNewsEvent(news));
      }
    });
  }

  List<NewsFilter> filters = [MockFilterDatabase.mainFilter];
  _runFilters(News news){
    var filter = filters.first;
    var processor = TokenFilterProcessor(news, filter);
    var res = processor.process();
    news.filterResult = FilterResult(res, filter: filter, action: filter.action);
  }

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsFocusEvent) {
      _focusedNews = event.news;
      _focusType = NewsItemFocusType.Focused;
      yield FocusedState(_focusedNews);
    } else if (event is NewNewsEvent) {
      switch (_focusType) {
        case NewsItemFocusType.Focused:
          yield new FocusedStillState(_focusedNews, event.news);
          break;
        case NewsItemFocusType.NoFocus:
          yield NoFocusState();
          break;
        case NewsItemFocusType.TopFocus:
          _focusedNews = NewsRepository.latestNews;
          yield TopFocusState(_focusedNews);
          break;
      }
    } else if (event is TopFocusEvent) {
      _focusType = NewsItemFocusType.TopFocus;
      _focusedNews = NewsRepository.latestNews;
      yield TopFocusState(_focusedNews);
    }
  }
}

enum NewsItemFocusType { Focused, NoFocus, TopFocus }
