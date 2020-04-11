import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/widget/news_meta_tags_list.dart';

class NewsMetaInfo extends StatelessWidget {
  final News news;

  NewsMetaInfo(this.news);

  @override
  Widget build(BuildContext context) {
    if(news.meta == null){
      return LinearProgressIndicator();
    }
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("is spam : ${news.meta.isSpam}"),
          _buildSpamReason(),
          _buildTags(context),
          _buildFilterResult(),
          _buildDeveloperTools(),
        ],
      ),
    );
  }

  Widget _buildTags(BuildContext context) {
    if (news.meta.tags == null || news.meta.tags?.length == 0) {
      return SizedBox.shrink();
    }
    return SizedBox(
        height: 50,
        child: NewsMetaTagsList(
            news.meta.tags, Theme.of(context).textTheme.bodyText2));
  }

  Widget _buildFilterResult() {
    if (news.filterResult != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("score: ${news.filterResult.score}"),
          Text("terms: ${news.filterResult.terms}"),
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildSpamReason() {
    String reason = "";
    for (var mark in news.meta.spamMarks) {
      reason += "${mark.reason}\n";
    }
    return Text(reason);
  }

  Widget _buildDeveloperTools() {
    return RaisedButton(child: Text("copy"), onPressed: (){
      Clipboard.setData(ClipboardData(text: news.content));
    },);
  }
}
