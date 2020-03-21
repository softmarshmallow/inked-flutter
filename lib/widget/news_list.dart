import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:inked/blocs/newslist/bloc.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/data/remote/realtime_news_receiver.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/utils/url_launch.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LiveNewsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LiveNewsListView();
}

const LIST_MAX = 1000;

class _LiveNewsListView extends State<LiveNewsListView> {
  final Dio dio = Dio();
  List<News> news = [];

  _LiveNewsListView() {
    RealtimeNewsReceiver().newsStream().listen((event) {
      addNews(event);
    });
  }

  void addNews(News newsItem) {
    setState(() {
      news.insert(0, newsItem);
      if (news.length > LIST_MAX) {
        news.removeRange(0, news.length - LIST_MAX);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NewsListView(news);
  }
}

class NewsListView extends StatelessWidget {
  final List<News> news;
  final ItemScrollController _scrollController = ItemScrollController();

  NewsListView(this.news, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NewsListBloc>(context);
    return BlocBuilder<NewsListBloc, ListViewState>(builder: (context, state) {
      return Scrollbar(
          child: news.isEmpty
              ? Text("loading..")
              : ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    var data = news[index];
                    var isFocused = bloc.state.news != null
                        ? data.id == bloc.state.news.id
                        : false;
                    return NewsListItem(data, isFocused: isFocused);
                  },
                ));
    });
  }

  _scrollToFocused() {
    _scrollController.jumpTo(index: 12);
  }
}

// region child
class NewsListItem extends StatelessWidget {
  final News data;
  final bool isFocused;
  var api = NewsApi(RemoteApiManager().getDio());

  NewsListItem(this.data, {this.isFocused = false});

  var markedSpam = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _onTap(context);
        },
        onDoubleTap: () {
          _onDoubleTap(context);
        },
        onLongPress: () {
          _onLongPress(context);
        },
        child: Container(
          color: isFocused ? Colors.grey : null,
          padding: EdgeInsets.only(left: 16, top: 8.0, right: 16, bottom: 8),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat().add_Hms().format(data.time),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                width: 12,
              ),
              _buildContentSection(context),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "content snippet",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.report),
                        color: !markedSpam ? Colors.black : Colors.red,
                        onPressed: () {
                          // mark as spam
                          markedSpam = true;
                          api.markSpamNews(
                              SpamMarkRequest(id: data.id, is_spam: true));
                        },
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildContentSection(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
            _buildContentSnippetSection(context)
          ],
        ));
  }

  // content snippet section that holds (chips, summary, ect...)
  Widget _buildContentSnippetSection(BuildContext context) {
    if (data.tags != null && data.tags.length > 0) {
      return SizedBox(
          height: 48,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: data.tags.length,
              itemBuilder: (BuildContext context, int index) {
                var item = data.tags[index];
                return Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Chip(label: Text(item)),
                );
              }));
    } else {
      return SizedBox.shrink();
    }
  }

  void _onTap(BuildContext context) {
    var bloc = BlocProvider.of<NewsListBloc>(context);
    bloc.add(NewsFocusEvent(data));
//    bloc.close();
  }

  void _onDoubleTap(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ContentDetailScreen.routeName, arguments: data);
  }

  void _onLongPress(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("quick action"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  ListTile(
                    title: Text("open news from site"),
                    onTap: () {
                      safelyLaunchURL(data.originUrl);
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

// endregion new item child
