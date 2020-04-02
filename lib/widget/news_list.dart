import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:inked/blocs/newslist/bloc.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/data/repository/news_repository.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/utils/url_launch.dart';
import 'package:intl/intl.dart';

class LiveNewsListView extends StatefulWidget {
  final api = NewsApi(RemoteApiManager().getDio());

  @override
  State<StatefulWidget> createState() => _LiveNewsListView();
}

class _LiveNewsListView extends State<LiveNewsListView> {
  NewsListBloc bloc;

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
                  ListTile(
                    title: Text("mark as spam"),
                    onTap: () {
                      widget.api.markSpamNews(SpamMarkRequest(id: news.id, is_spam: true));
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Thanks for the feedback. \"${news.title}\" has been marked as spam.')));
                    },
                  ),
                  ListTile(
                    title: Text("mark as NOT spam"),
                    onTap: () {
                      widget.api.markSpamNews(SpamMarkRequest(id: news.id, is_spam: false));
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Thanks for the feedback. \"${news.title}\" has been marked as NOT spam.')));
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
    return BlocBuilder<NewsListBloc, NewsListState>(builder: (context, state) {
      return NewsListView(
        state.newses,
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
  int focusedIndex;

  NewsListView(this.news, {this.defaultItemAction, this.focusedNews, Key key})
      : super(key: key);
  final NewsListItemActions defaultItemAction;
  var api = NewsApi(RemoteApiManager().getDio());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToFocused());
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
                  if (isFocused) focusedIndex = index;
                  return NewsListItem(
                    data,
                    isFocused: isFocused,
                    actions: defaultItemAction,
                    trail: data.filterResult != null && data.filterResult.matched && data.filterResult.action == FilterAction.Hide ? [] : <Widget>[
                      IconButton(
                        icon: Icon(Icons.report),
                        onPressed: () {
                          // mark as spam
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Thanks for the feedback. \"${data.title}\" has been marked as spam.')));
                          api.markSpamNews(
                              SpamMarkRequest(id: data.id, is_spam: true));
                        },
                      )
                    ],
                  );
                },
              ));
  }

  _scrollToFocused() {
    // todo this is not working
    if (_scrollController.isAttached) {
      if (focusedIndex != null) {
        _scrollController.scrollTo(
            index: focusedIndex, duration: Duration(milliseconds: 200));
      }
    }
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
  final List<Widget> trail;
  final bool isFocused;
  Color _textColor = Colors.black;

  NewsListItem(this.data, {this.isFocused = false, this.actions, this.trail}){

    // todo change logic later....
    // if spam mark filter result
    if (data.meta.spamMarks != null) {
      data.meta.spamMarks.forEach((element) {
        switch (element.spam){
          case SpamTag.SPAM:
            data.filterResult = FilterResult(true, action: FilterAction.Hide, filter: TokenFilter("server matching"));
            break;
          case SpamTag.NOTSPAM:
            break;
          case SpamTag.UNTAGGED:
            break;
        }
      });
    }

    // initialize global text color by filter status
    if (data.filterResult != null && data.filterResult.matched) {
      switch(data.filterResult.action){
        case FilterAction.Hide:
          _textColor = Colors.black45;
          break;
        case FilterAction.Notify:
          _textColor = Colors.red;
          break;
        case FilterAction.None:
          _textColor = Colors.black;
          break;
      }
    }
  }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat().add_Hms().format(data.time),
                style: Theme.of(context).textTheme.subtitle1.copyWith(color: _textColor),
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
                    "${data.provider}",
                    style: Theme.of(context).textTheme.caption.copyWith(color: _textColor),
                  ),
                  trail != null ? Row(children: trail) : SizedBox.shrink()
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildContentSection(BuildContext context) {
    var titleTextStyle = Theme.of(context).textTheme.headline6.copyWith(color: _textColor);
    if (data.filterResult != null && data.filterResult.matched) {
      switch(data.filterResult.action){
        case FilterAction.Hide:
          titleTextStyle = Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w300);
          break;
        case FilterAction.Notify:
          titleTextStyle = titleTextStyle.copyWith(fontWeight: FontWeight.bold);
          break;
        case FilterAction.None:
          titleTextStyle = titleTextStyle.copyWith(fontWeight: FontWeight.normal);
          break;
      }
    }


    return Expanded(
        flex: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
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
