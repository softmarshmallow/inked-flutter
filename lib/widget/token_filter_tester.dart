import 'package:flutter/material.dart';
import 'package:inked/data/local/mock/mock_news_db.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/widget/content_detail.dart';

class TokenFilterTester extends StatefulWidget {
  TokenFilterTester({Key key}) : super(key: key);

  @override
  _TokenFilterTesterState createState() => _TokenFilterTesterState();
}

class _TokenFilterTesterState extends State<TokenFilterTester> {
  News news = MockNewsDatabase.allNewsDataList.first;
  var api = NewsApi(RemoteApiManager().getDio());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("test the filter"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 300,
                child: Column(
                  children: <Widget>[
                    RaisedButton(child: Text("load other news"), onPressed: () async {
                      var fetched = await api.getSpamNews();
                      setState(() {
                        news = fetched;
                      });
                    },),
                    ContentDetailView(news, readOnly: true,),
                  ],
                )
              ),
              Text("result = >>>")
            ],
          )
        ],
      ),
    );
  }
}