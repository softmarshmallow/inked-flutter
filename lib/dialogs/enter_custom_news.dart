import 'package:flutter/material.dart';
import 'package:inked/data/model/news.dart';

class EnterCustomNewsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EnterCustomNewsDialogState();
}

class _EnterCustomNewsDialogState extends State<EnterCustomNewsDialog> {
  String _title;
  String _content;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.headline3,
                    autofocus: true,
                    maxLines: 1,
                    onChanged: (t) {
                      _title = t;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'enter news title'),
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 12,
                    autofocus: true,
                    onChanged: (t) {
                      _content = t;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'enter news content'),
                  ),
                  _buildActionSection()
                ],
              ),
            )));
  }

  Widget _buildActionSection() {
    onSubmitPressed() {
      if (_formKey.currentState.validate()) {
        var news = News(title: _title, content: _content, time: DateTime.now());
        print("new content from user is ${news.content}");
        Navigator.of(context).pop(news);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text("submit"),
          onPressed: onSubmitPressed,
        ),
      ],
    );
  }
}
