import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/realtime_news_receiver.dart';

abstract class NewsListEvent extends Equatable {
  const NewsListEvent();

  @override
  List<Object> get props => [];
}

class NewsFocusEvent extends NewsListEvent {
  const NewsFocusEvent(this.news);

  final News news;
}

class NewNewsEvent extends NewsListEvent{
  const NewNewsEvent(this.news);
  final News news;
}

abstract class ListViewState extends Equatable {
  const ListViewState(this.news);

  final News news;

  @override
  List<Object> get props => [news];
}

class EmptyFocusState extends ListViewState {
  EmptyFocusState(News news) : super(news);
}

class FocusedState extends ListViewState {
  FocusedState(News news) : super(news);
}

class NewNewsReceiveState extends ListViewState {
  NewNewsReceiveState(News news) : super(news);
}

class NewsListBloc extends Bloc<NewsListEvent, ListViewState> {
  @override
  ListViewState get initialState => EmptyFocusState(null);

  NewsListBloc(){
    RealtimeNewsReceiver().newsStream().listen((event) {
      add(NewNewsEvent(event));
    });
  }


  @override
  Stream<ListViewState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsFocusEvent) {
      yield FocusedState(event.news);
    }else if (event is NewNewsEvent) {
      if (state is EmptyFocusState) {
        yield FocusedState(event.news);
      }  else{
        yield NewNewsReceiveState(event.news);
      }
    }
  }
}
