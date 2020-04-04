import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/data/local/mock/mock_filter_db.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/realtime_news_receiver.dart';
import 'package:inked/data/repository/news_repository.dart';
import 'package:inked/utils/filters/token_filter_processor.dart';

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

class NewsUpdatedEvent extends NewsListEvent{
  const NewsUpdatedEvent(); // this.news
//  final News news;
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
  FocusedState(News news) : super(news, NewsRepository().DATA);
}

class FocusedStillState extends FocusedState {
  FocusedStillState(News news, this.newNews) : super(news);
  final News newNews;

  @override
  List<Object> get props => [news, newNews];
}

class TopFocusState extends NewsListState {
  TopFocusState(News news) : super(news, NewsRepository().DATA);
}

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  @override
  NewsListState get initialState => NoFocusState();

  NewsItemFocusType _focusType = NewsItemFocusType.TopFocus;
  News _focusedNews;
  NewsRepository repository = NewsRepository();

  NewsListBloc() {
    RealtimeNewsReceiver().steam().listen((news) {
//      _runFilters(news);
      var isAdded = repository.add(news);
      if (isAdded) {
        add(NewNewsEvent(news));
      }
    });
    repository.onNewsUpdated = (updated){
      add(NewNewsEvent(updated));
    };
  }

  List<NewsFilter> filters = [MockFilterDatabase.mainFilter];

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    NewsListState newsUpdate(News news){
      switch (_focusType) {
        case NewsItemFocusType.Focused:
          return new FocusedStillState(_focusedNews, news);
          break;
        case NewsItemFocusType.NoFocus:
          return NoFocusState();
          break;
        case NewsItemFocusType.TopFocus:
          _focusedNews = repository.latestNews;
          return TopFocusState(_focusedNews);
          break;
      }
    }

    if (event is NewsFocusEvent) {
      _focusedNews = event.news;
      _focusType = NewsItemFocusType.Focused;
      yield FocusedState(_focusedNews);
    } else if (event is NewNewsEvent) {
      yield newsUpdate(event.news);
    } else if (event is TopFocusEvent) {
      _focusType = NewsItemFocusType.TopFocus;
      _focusedNews = repository.latestNews;
      yield TopFocusState(_focusedNews);
    }else if (event is NewsUpdatedEvent){
      yield newsUpdate(repository.latestNews);
    }
  }
}

enum NewsItemFocusType { Focused, NoFocus, TopFocus }
