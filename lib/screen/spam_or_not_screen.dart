import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';

///
/// README
/// this screen is for spam detection data collection.
/// game like design of document labeling
///

class SpamOrNotScreen extends StatefulWidget {
  static const routeName = "/misc/spam-or-not";

  @override
  State<StatefulWidget> createState() => _SpamOrNotScreenState();
}

const isSpamShortcut = "x";
const isNotSpamShortcut = "z";

class _SpamOrNotScreenState extends State<SpamOrNotScreen> {
  final FocusNode _focusNode = FocusNode();
  final _scaffoldState = GlobalKey<ScaffoldState>();
  News news;
  var api = NewsApi(RemoteApiManager().getDio());
  var spamLabelledCountMap = {"spam": 0, "normal":0};

  @override
  void initState() {
    super.initState();
    _loadNewDocument();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("spam or not"),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                "press > / < arrow key to move back / forward.\nhit (z) key to mark document as non-spam, hit (x) key to mark document as spam",
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(12),
            ),
            _buildDocumentSection(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                    onPressed: _onIsNotSpamPressed,
                    icon: Icon(Icons.done_all),
                    label: Text("not spam ($isNotSpamShortcut)")),
                SizedBox(
                  width: 16,
                ),
                RaisedButton.icon(
                    onPressed: _onIsSpamPressed,
                    icon: Icon(Icons.done_all),
                    label: Text("spam ($isSpamShortcut)")),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text("spam: ${spamLabelledCountMap['spam']}\nnormal: ${spamLabelledCountMap['normal']}", style: Theme.of(context).textTheme.caption,),
            )
          ],
        ),
        onKey: (key) {
          if (key.runtimeType.toString() == 'RawKeyDownEvent') {
            String _keyCode = key.logicalKey.keyLabel;
            if (_keyCode == isNotSpamShortcut) {
              _onIsNotSpamPressed();
            } else if (_keyCode == isSpamShortcut) {
              _onIsSpamPressed();
            }
          }
        },
      ),
    );
  }

  Widget _buildDocumentSection() {
    const loadingText = "loading...";
    return SizedBox(
      width: 900,
      height: 500,
      child: Container(
          child: news != null
              ? SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          news.title,
                          style: Theme.of(context).textTheme.headline4,
                        )),
                    Html(
                      data: news.content,
                      padding: EdgeInsets.all(12),
                    )
                  ],
                ))
              : Text(loadingText)),
    );
  }

  _onIsSpamPressed() async {
    _showSnackbar("marked as spam", Colors.deepOrange);
    spamLabelledCountMap['spam'] += 1;
    await _provideDocumentFeedback(SpamTag.SPAM);
    _loadNewDocument();
  }

  _onIsNotSpamPressed() async {
    _showSnackbar("marked as non spam", Colors.blueAccent);
    spamLabelledCountMap['normal'] += 1;
    await _provideDocumentFeedback(SpamTag.NOTSPAM);
    _loadNewDocument();
  }

  _provideDocumentFeedback(SpamTag tag) async {
    await api.markSpamNews(new SpamMarkRequest(id: news.id, tag: tag, reason: "no reason provided")); // todo provide reason
  }

  _showSnackbar(String message, Color color) {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(milliseconds: 200),
    ));
  }

  _loadNewDocument() async {
    setState(() {
      news = null;
    });

    var newCandidate = await api.getUntaggedNews();
    setState(() {
      news = newCandidate;
    });
  }
}
