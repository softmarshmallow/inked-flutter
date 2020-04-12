import 'package:after_layout/after_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/user_api.dart';
import 'package:inked/data/repository/favorite_news_repository.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/utils/date/datetime_utls.dart';
import 'package:inked/widget/news_list.dart';

class FavoriteNewsScreen extends StatefulWidget {
  static const routeName = "/news/favorite";

  @override
  State<StatefulWidget> createState() => _FavoriteNewsScreenState();
}

class _FavoriteNewsScreenState extends State<FavoriteNewsScreen>
    with AfterLayoutMixin<FavoriteNewsScreen> {
  List<News> favoriteNewses = [];
  UserApi api;
  FavoriteNewsRepository repository;

  _FavoriteNewsScreenState(){
    api = UserApi(RemoteApiManager().getDio());
    repository = FavoriteNewsRepository();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    setState(() {
      favoriteNewses = repository.DATA;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("saved"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c, i) {
                var data = favoriteNewses[i];
                return NewsListItem(data, timeFormatType: TimeFormatType.THIS_YEAR, actions: NewsListItemActions((n){
                  Navigator.of(context).pushNamed(NewsContentDetailScreen.routeName, arguments: data);
                }),);
              },
              itemCount: favoriteNewses.length,
            )
          ],
        ),
      ),
    );
  }
}
