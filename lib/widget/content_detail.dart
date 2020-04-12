import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:inked/data/local/mock/mock_news_db.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/user_api.dart';
import 'package:inked/data/repository/favorite_news_repository.dart';
import 'package:inked/utils/url_launch.dart';
import 'package:inked/widget/news_meta_info.dart';

class ContentDetailView extends StatefulWidget {
  final readOnly;
  final News news;

  ContentDetailView(this.news, {this.readOnly = false});

  @override
  State<StatefulWidget> createState() => _ContentDetailView();
}

class _ContentDetailView extends State<ContentDetailView>
    with AfterLayoutMixin<ContentDetailView> {
  UserApi api;
  FavoriteNewsRepository repository;
  bool isFavorite = false;

  @override
  void afterFirstLayout(BuildContext context) {
    api = UserApi(RemoteApiManager().getDio());
  }

  _initFavorite() {
    repository = FavoriteNewsRepository();
    setState(() {
      isFavorite = repository.isFavorite(widget.news);
    });
  }

  @override
  Widget build(BuildContext context) {
    _initFavorite();
    return Container(
        child: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildTitleSection(),
              Divider(),
              _buildContentSection(),
              Divider(),
              _buildFooterSection()
            ],
          ),
        ),
        _buildStickyToolbar(),
      ],
    ));
  }

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
                    isFavorite = !isFavorite;
                    // todo clean
                    if (isFavorite) {
                      // todo clean this
                      repository.add(widget.news);
                      api
                          .postRegisterFavoriteNews(
                              new UpdateFavoriteNewsRequest(widget.news.id))
                          .then((value) => {repository.set(value)});
                    } else {
                      // todo clean this
                      repository.remove(widget.news);
                      api
                          .removeFavoriteNews(
                              new UpdateFavoriteNewsRequest(widget.news.id))
                          .then((value) => {repository.set(value)});
                    }

                    setState(() {});
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
      onLinkTap: (link) {
        safelyLaunchURL(link);
      },
      padding: EdgeInsets.all(12),
    );
  }

  Widget _buildFooterSection() {
    return NewsMetaInfo(widget.news);
  }
}
