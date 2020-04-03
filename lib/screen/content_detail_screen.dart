import 'package:after_layout/after_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/utils/route_interface.dart';
import 'package:inked/widget/content_detail.dart';

class ContentDetailScreen extends StatefulWidget{
  static const routeName = "news/detail";
  @override
  State<StatefulWidget> createState() => _ContentDetailScreen();

}

class _ContentDetailScreen extends State<ContentDetailScreen> with AfterLayoutMixin<ContentDetailScreen>{

  News news;



  @override
  void afterFirstLayout(BuildContext context) {
    if (news != null){
      NewsApi(Dio()).getNewsItem(news.id).then((value){
        print("refreshed news for detail screen : ${value.title}");
        setState(() {
          news = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (news == null){
      news = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: ContentDetailView(news),
    );
  }
}
