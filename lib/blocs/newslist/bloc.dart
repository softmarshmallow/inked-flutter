import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/data/model/news.dart';

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object> get props => [];
}

class NewsFocusEvent extends NewsListEvent {
  const NewsFocusEvent(this.news);

  final News news;
}

abstract class ListViewState extends Equatable {
  const ListViewState(this.news);

  final News news;

  @override
  List<Object> get props => [news];
}

class EmptyFocusState extends ListViewState {
  EmptyFocusState() : super(null);
}

class FocusedState extends ListViewState {
  FocusedState(News news) : super(news);
}

class NewsListBloc extends Bloc<NewsListEvent, ListViewState> {
  @override
  ListViewState get initialState => EmptyFocusState();

  @override
  Stream<ListViewState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsFocusEvent) {
      yield FocusedState(event.news);
    }
  }
}
