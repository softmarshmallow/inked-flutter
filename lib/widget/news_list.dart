import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/local/mock/mock_news_db.dart';
import 'package:inked/data/model/news.dart';

class NewsListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsListView();
}

class _NewsListView extends State<NewsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: _buildListItems()),
    );
  }

  List<Widget> _buildListItems() {
    List<Widget> items = [];
    MockNewsDatabase.allNewsDataList.forEach((d) => items.add(NewsListItem(d)));
    return items;
  }
}

// region child
class NewsListItem extends StatelessWidget {
  final News data;

  NewsListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _onTap,
        onDoubleTap: _onDoubleTap,
        onLongPress: _onLongPress,
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 8.0, right: 16, bottom: 8),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "12:11 12",
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

  void _onDoubleTap() {}

  void _onLongPress() {}
}

// endregion new item child
