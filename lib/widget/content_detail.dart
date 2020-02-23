import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:inked/data/local/mock/mock_news_db.dart';
import 'package:inked/data/model/news.dart';

class ContentDetailView extends StatefulWidget {
  final News news;

  ContentDetailView(this.news);

  @override
  State<StatefulWidget> createState() => _ContentDetailView();
}

class _ContentDetailView extends State<ContentDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTitleSection(),
          _buildContentSection(),
          _buildFooterSection()
        ],
      ),
    ));
  }

  Widget _buildTitleSection() {
    return Container(
        padding: EdgeInsets.only(left: 12, top: 8),
        child: Text(
          widget.news.title,
          style: Theme.of(context).textTheme.headline6,
        ));
  }

  Widget _buildContentSection() {
    return Html(
      data: MockNewsDatabase.html_example,
      padding: EdgeInsets.all(12),
    );
  }

  Widget _buildFooterSection() {
    return SizedBox.shrink();
  }
}
