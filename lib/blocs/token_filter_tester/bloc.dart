import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/data/local/mock/mock_filter_db.dart';
import 'package:inked/data/local/mock/mock_news_db.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';

abstract class FilterTesterEvent extends Equatable {
  const FilterTesterEvent();

  @override
  List<Object> get props => [];
}

class TestNewsUpdateEvent extends FilterTesterEvent {
  const TestNewsUpdateEvent(this.news);

  final News news;
}

class TestFilterUpdateEvent extends FilterTesterEvent {
  const TestFilterUpdateEvent(this.filter);

  final TokenFilter filter;
}

abstract class TokenFilterTesterViewState extends Equatable {
  const TokenFilterTesterViewState(this.news, this.filter);

  final News news;
  final TokenFilter filter;

  @override
  List<Object> get props => [news];
}

class InitialState extends TokenFilterTesterViewState {
  InitialState() : super(MockNewsDatabase.allNewsDataList.first, null);
}

class TestingState extends TokenFilterTesterViewState {
  TestingState(News news, TokenFilter filter) : super(news, filter);
}

class FilterTesterBloc extends Bloc<FilterTesterEvent, TokenFilterTesterViewState> {
  @override
  TokenFilterTesterViewState get initialState => InitialState();

  News news = MockNewsDatabase.allNewsDataList.first;
  TokenFilter filter;

  @override
  Stream<TokenFilterTesterViewState> mapEventToState(FilterTesterEvent event) async* {
    if (event is TestNewsUpdateEvent) {
      news = event.news;
    }else if (event is TestFilterUpdateEvent) {
      filter = event.filter;
    }
    yield TestingState(news, filter);
  }
}
