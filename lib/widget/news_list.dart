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
  NewsListBloc bloc;

  _LiveNewsListView() {
    RealtimeNewsReceiver().newsStream().listen((event) {
      addNews(event);
    });
  }

  onItemTap(News news) {
    bloc.add(NewsFocusEvent(news));
  }

  onItemDoubleTap(News news) {
    Navigator.of(context)
        .pushNamed(ContentDetailScreen.routeName, arguments: news);
  }

  onItemLongPress(News news) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("quick action"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    news.title,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  ListTile(
                    title: Text("open news from site"),
                    onTap: () {
                      safelyLaunchURL(news.originUrl);
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

  void addNews(News newsItem) {
    setState(() {
      news.insert(0, newsItem);
      if (news.length > LIST_MAX) {
        news.removeRange(0, news.length - LIST_MAX);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<NewsListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListBloc, ListViewState>(builder: (context, state) {
      return NewsListView(news,
          defaultItemAction: NewsListItemActions(onItemTap,
              onDoubleTap: onItemDoubleTap, onLongPress: onItemLongPress),
        focusedNews: state.news,
      );
    });
  }
}

class NewsListView extends StatelessWidget {
  final List<News> news;
  final News focusedNews;
  final ItemScrollController _scrollController = ItemScrollController();
  BuildContext context;

  NewsListView(this.news, {this.defaultItemAction, this.focusedNews, Key key})
      : super(key: key);
  final NewsListItemActions defaultItemAction;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scrollbar(
        child: news.isEmpty
            ? Text("loading..")
            : ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                itemCount: news.length,
                itemBuilder: (context, index) {
                  var data = news[index];
                  var isFocused =
                      focusedNews != null ? data.id == focusedNews.id : false;
                  return NewsListItem(
                    data,
                    isFocused: isFocused,
                    actions: defaultItemAction,
                  );
                },
              ));
  }

  _scrollToFocused() {
    _scrollController.jumpTo(index: 12);
  }
}

class NewsListItemActions {
  NewsListItemActions(this.onTap, {this.onLongPress, this.onDoubleTap});

  final Function(News news) onTap;
  final Function(News news) onLongPress;
  final Function(News news) onDoubleTap;
}

// region child
class NewsListItem extends StatelessWidget {
  final News data;
  NewsListItemActions actions;
  final bool isFocused;
  var api = NewsApi(RemoteApiManager().getDio());

  NewsListItem(this.data, {this.isFocused = false, this.actions});

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
    actions?.onTap?.call(data);
  }

  void _onDoubleTap(BuildContext context) {
    actions?.onDoubleTap?.call(data);
  }

  void _onLongPress(BuildContext context) {
    actions?.onLongPress?.call(data);
  }
}

// endregion new item child
