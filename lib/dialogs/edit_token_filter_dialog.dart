import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/widget/section.dart';

class EditTokenFilterDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditTokenFilterDialog();
}

class _EditTokenFilterDialog extends State<EditTokenFilterDialog> {
  FilterType _filterType = FilterType.Ignore;
  FilterScope _filterScope = FilterScope.Title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("token filter"),
      content: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(labelText: "token"),
          ),
          Section(
            "filter type",
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('ignore following token'),
                  leading: Radio(
                    value: FilterType.Ignore,
                    groupValue: _filterType,
                    onChanged: (value) {
                      setState(() {
                        _filterType = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('notify following token'),
                  leading: Radio(
                    value: FilterType.Notify,
                    groupValue: _filterType,
                    onChanged: (value) {
                      setState(() {
                        _filterType = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Section(
            "scope",
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('title'),
                  leading: Radio<FilterScope>(
                    value: FilterScope.Title,
                    groupValue: _filterScope,
                    onChanged: (value) {
                      setState(() {
                        _filterScope = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('content'),
                  leading: Radio<FilterScope>(
                    value: FilterScope.Body,
                    groupValue: _filterScope,
                    onChanged: (value) {
                      setState(() {
                        _filterScope = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
      actions: <Widget>[
        FlatButton(
          child: Text("cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("confirm"),
          onPressed: () {},
        ),
      ],
    );
  }
}
