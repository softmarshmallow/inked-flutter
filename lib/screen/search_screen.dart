import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:inked/utils/date/datetime_utls.dart';
import 'package:inked/utils/elasticsearch/elasticsearch.dart';
import 'package:inked/utils/elasticsearch/model.dart';
import 'package:inked/utils/text_highlight/highlighted_text.dart';
import 'package:inked/widget/appbar_linear_progress_indicator.dart';
import 'package:inked/widget/news_list.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _term;
  List<NewsDocumentResult> searchResults = [];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("search"),
          actions: <Widget>[
            SizedBox(
              width: 300,
              height: 150,
              child: TextField(
                  autofocus: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter a search term'),
                onChanged: (s) {
                  setState(() {
                    _term = s;
                  });
                },
                onSubmitted: (s) {
                  _search();
                },
              ),
            )
          ],
          bottom: _loading ? AppbarLinearProgressIndicator(
            backgroundColor: Colors.black,
          ) : null,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              searchResults.length > 0 ? ListView.builder(
                  itemBuilder: (c, i) {
                    var d = searchResults[i];
                    return NewsListItem(d.source,
                        timeFormatType: TimeFormatType.THIS_MONTH,
                        bottom: _buildContentSnippetSection(d));
                  },
                  itemCount: searchResults.length,
                  shrinkWrap: true) : Text("no result for search term: $_term")
            ],
          ),
        ));
  }

  Widget _buildContentSnippetSection(NewsDocumentResult result) {
    String combined = "";
    result?.highlight?.content?.forEach((element) {
      combined += element + "\n___\n";
    });

    if (combined.isNotEmpty) {
      return buildTextFromEm(combined,
          Theme.of(context).textTheme.caption.copyWith(color: Colors.red));
    }
    return SizedBox.shrink();
  }

  _search() async {
    var esHost = DotEnv().env["ES_HOST"];

    setState(() {
      _loading = true;
    });

    searchResults = await Elasticsearch(esHost).searchMultiMatch(_term);
    setState(() {
      _loading = false;
      searchResults = searchResults;
    });
  }
}
