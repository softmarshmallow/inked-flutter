import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:inked/data/local/mock/mock_news_db.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/url_launch.dart';

class ContentDetailView extends StatefulWidget {
  final News news;
  final readOnly;

  ContentDetailView(this.news, {this.readOnly = false});

  @override
  State<StatefulWidget> createState() => _ContentDetailView();
}

class _ContentDetailView extends State<ContentDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildTitleSection(),
              _buildContentSection(),
              _buildFooterSection()
            ],
          ),
        ),
        _buildStickyToolbar(),
      ],
    ));
  }

  bool isFavorite = false;

  Widget _buildStickyToolbar() {
    return widget.readOnly
        ? SizedBox.shrink()
        : Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon:
                      Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                ),
                IconButton(
                  onPressed: () {
                    safelyLaunchURL(widget.news.originUrl);
                  },
                  icon: Icon(Icons.open_in_new),
                ),
              ],
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
      data: widget.news.content,
      padding: EdgeInsets.all(12),
    );
  }

  Widget _buildFooterSection() {
    return SizedBox.shrink();
  }
}
