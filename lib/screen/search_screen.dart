import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/search_api.dart';
import 'package:inked/remote_ui/layouts/search.layout.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/utils/date/datetime_utls.dart';
import 'package:inked/utils/elasticsearch/elasticsearch.dart';
import 'package:inked/utils/elasticsearch/model.dart';
import 'package:inked/widget/appbar_linear_progress_indicator.dart';
import 'package:inked/widget/news_list.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _term = "";
  String lastSearchTerm = "";

  String get term {
    return _term;
  }

  set term(String v) {
    setState(() {
      _term = v;
      isInitialState = v == "";
      if (term != lastSearchTerm) {
        // reset search results
        searchResults = null;
      }
    });
  }

  TextEditingController _inputController = TextEditingController();
  SearchResponse<NewsDocumentResult> searchResults;
  List<SearchLayoutBase> blankLayout;
  bool _loading = false;
  int page = 1;
  bool isInitialState = true;
  var api = SearchApi(RemoteApiManager().getDio());
  final ScrollController _scrollController = ScrollController();
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("search"),
          bottom: _loading
              ? AppbarLinearProgressIndicator(
                  backgroundColor: Colors.black,
                )
              : null,
        ),
        body: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: <Widget>[_buildSearchInput(), _buildBody()],
              ),
            )));
  }

  Widget _buildSearchResultMeta() {
    var child;
    if (searchResults == null) {
      child = Text(
          "no result for search term: $term (hit enter or press search to search)");
    } else {
      child = Text(
          "page: ${page} total : ${searchResults.total} took: ${searchResults.took / 100} seconds, maxScore: ${searchResults.maxScore}");
    }
    return Container(
      child: child,
      padding: EdgeInsets.all(16),
    );
  }

  Widget _buildSearchResultList() {
    if (searchResults != null && searchResults.documents.length > 0) {
      return ListView.builder(
          itemBuilder: (c, i) {
            var d = searchResults.documents[i];

            // todo change this location
            d.source.filterResult = NewsFilterResult(true,
                action: FilterAction.IGNORE, highlights: d.highlight);

            return Container(
              padding: EdgeInsets.only(top: 24),
              child: NewsListItem(
                d.source,
                timeFormatType: TimeFormatType.THIS_MONTH,
                actions: NewsListItemActions(_onItemTap),
              ),
            );
          },
          itemCount: searchResults.documents.length,
          shrinkWrap: true);
    }
    return SizedBox.shrink();
  }

  _onItemTap(News n) {
    Navigator.of(context)
        .pushNamed(NewsContentDetailScreen.routeName, arguments: n);
  }

  Widget _buildPagination() {
    changePage(int to) {
      if (to > 0) {
        setState(() {
          page = to;
        });
      }
      _scrollController.jumpTo(0);
      _search();
    }

    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            changePage(page - 1);
          },
        ),
        Text("$page"),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            changePage(page + 1);
          },
        ),
      ],
    );
  }

  Widget _buildSearchInput() {
    return Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _inputController,
                autofocus: true,
                decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Enter a search term'),
                onChanged: (s) {
                  term = s;
                },
                onSubmitted: (s) {
                  _search();
                },
              ),
            ),
            Row(
              children: [
                _buildDurationPicker(),
                _buildCustomDatePicker(),
                Spacer(),
                RaisedButton(
                  child: Text("search"),
                  onPressed: _search,
                )
              ],
            ),
          ],
        ));
  }

  Widget _buildBody() {
    return isInitialState ? _buildInitialState() : _buildSearchState();
  }

  Widget _buildSearchState() {
    return Column(
      children: <Widget>[
        _buildSearchResultMeta(),
        _buildSearchResultList(),
        _buildPagination()
      ],
    );
  }

  Widget _buildInitialState() {
    api.getBlank().then((value) {
      setState(() {
        blankLayout = value;
      });
    });

    if (blankLayout == null) {
      return CircularProgressIndicator();
    }

    if (blankLayout.length == 0) {
      return Text("no search suggestions");
    }

    return ListView.builder(
      itemBuilder: (c, i) {
        var item = blankLayout[i];
        String t = item.title.text;
        return ListTile(
          title: Text(t),
          onTap: () {
            term = t;
            _inputController.text = term;
            _search();
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("remove search history"),
                    content: Text("remove \"${t}\" from history?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text("remove"),
                        onPressed: () {
                          api.removeSearchHistory(CrudSearchHistoryRequest(t));
                          setState(() {}); // reload black state
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
        );
      },
      itemCount: blankLayout.length,
      shrinkWrap: true,
    );
  }

  Widget _buildRecentHistorySelection() {}

  Widget _buildCustomDatePicker() {
    if (useCustomDate) {
      return Container(
        child: FlatButton(
          child: Text(
              "from ${formatTimeHuman(startDate, TimeFormatType.THIS_YEAR)}"),
          onPressed: () async {
            var newStartDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2030),
              builder: (BuildContext context, Widget child) {
                return child;
              },
            );
            if (newStartDate != null) {
              setState(() {
                startDate = newStartDate;
              });
            }
          },
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  static const Map<String, Duration> durationMap = {
    "1 hour": Duration(hours: 1),
    "1 day": Duration(days: 1),
    "1 week": Duration(days: 7),
    "2 weeks": Duration(days: 14),
    "1 month": Duration(days: 30),
    "3 months": Duration(days: 90),
    "custom": null
  };
  static const defaultKey = "2 weeks";
  String durationKey = defaultKey;
  bool useCustomDate = false;
  Duration duration = durationMap[defaultKey];

  Widget _buildDurationPicker() {
    return DropdownButton(
      value: durationKey,
      onChanged: (String value) {
        setState(() {
          durationKey = value;
          duration = durationMap[value];
          useCustomDate = value == "custom";
          if (!useCustomDate) {
            startDate = DateTime.now().subtract(duration);
          }
        });
      },
      items: durationMap.keys.map((String action) {
        return DropdownMenuItem<String>(
            value: action, child: Text(action.toString()));
      }).toList(),
    );
  }

  _search() async {
    lastSearchTerm = term;
    print("search started with term of '$term'");

    var esHost = DotEnv().env["ES_HOST"];
    api.createSearchHistory(CrudSearchHistoryRequest(term));
    setState(() {
      _loading = true;
    });

    searchResults = await Elasticsearch(esHost)
        .searchMultiMatch(term, page: page, timeFrom: startDate);
    setState(() {
      _loading = false;
      searchResults = searchResults;
    });
  }
}
