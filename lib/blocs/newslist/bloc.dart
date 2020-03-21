import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/realtime_news_receiver.dart';
import 'package:inked/data/repository/news_repository.dart';

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
  const NewsListState(this.news);

  final News news;

  @override
  List<Object> get props => [news];
}

class NoFocusState extends NewsListState {
  NoFocusState() : super(null);
}

class FocusedState extends NewsListState {
  FocusedState(News news) : super(news);
}

class FocusedStillState extends FocusedState{
  FocusedStillState(News news, this.newNews) : super(news);
  final News newNews;

  @override
  List<Object> get props => [news, newNews];
}

class TopFocusState extends NewsListState {
  TopFocusState(News news) : super(news);
}

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  @override
  NewsListState get initialState => NoFocusState();

  NewsItemFocusType _focusType = NewsItemFocusType.TopFocus;
  News _focusedNews;

  NewsListBloc() {
    RealtimeNewsReceiver().newsStream().listen((news) {
      NewsRepository.addNews(news);
      add(NewNewsEvent(news));
    });
  }

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsFocusEvent) {
      _focusedNews = event.news;
      _focusType = NewsItemFocusType.Focused;
      yield FocusedState(_focusedNews);
    } else if (event is NewNewsEvent) {
      print("new news event. focus >>> ${_focusType}. news >>> ${event.news}");
      switch (_focusType) {
        case NewsItemFocusType.Focused:
//          print('case:: focused');
          yield new FocusedStillState(_focusedNews, event.news);
//          yield TopFocusState(_focusedNews);

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
