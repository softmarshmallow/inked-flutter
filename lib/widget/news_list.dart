import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

final logger = Logger();

class NewsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsListView();
}

class _NewsListView extends State<NewsListView> {
  final Dio dio = Dio();
  NewsApi _api;
  List<News> news = [];

  _NewsListView() {
    _api = NewsApi(dio);
    _api.getNews().then((value) {
      print("value: $value");
      setState(() {
        news = value;
      });
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("res: $res");
          logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        var isFocused = index == 3;
        return NewsListItem(news[index], isFocused: isFocused);
      },
    ));
  }
}

// region child
class NewsListItem extends StatelessWidget {
  final News data;
  final bool isFocused;
  NewsListItem(this.data, {this.isFocused = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _onTap();
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
              Text(
                "content snippet",
                style: Theme.of(context).textTheme.subtitle1,
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

  void _onTap() {}

  void _onDoubleTap(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ContentDetailScreen.routeName, arguments: data);
  }

  void _onLongPress(BuildContext context) {
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
                      _launchURL(data.originUrl);
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
