import 'package:flutter/material.dart';
import 'package:inked/dialogs/edit_token_filter_dialog.dart';

class FilterCreateScreen extends StatefulWidget {
  static const routeName = "/settings/filter/new";

  @override
  State<StatefulWidget> createState() => _FilterCreateScreenState();
}

class _FilterCreateScreenState extends State<FilterCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("create new filter"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            RaisedButton(
              child: Text("create new query"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => EditTokenFilterDialog());
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
      ),
    );
  }
}
