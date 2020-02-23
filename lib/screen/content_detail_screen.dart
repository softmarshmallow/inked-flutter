import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/route_interface.dart';
import 'package:inked/widget/content_detail.dart';

class ContentDetailScreen extends StatefulWidget{
  static const routeName = "news/detail";
  @override
  State<StatefulWidget> createState() => _ContentDetailScreen();

}

class _ContentDetailScreen extends State<ContentDetailScreen> {
  News news;
  @override
  Widget build(BuildContext context) {
    news = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: ContentDetailView(news),
    );
  }
}
