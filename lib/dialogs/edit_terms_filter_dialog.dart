import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/widget/section.dart';

class EditTermsFilterDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditTermsFilterDialogState();
}

class _EditTermsFilterDialogState extends State<EditTermsFilterDialog> {
  String terms;
  FilterAction action = FilterAction.NOTIFY;

  Widget _buildActionSelect() {
    return DropdownButton(
      value: action,
      onChanged: (FilterAction value) {
        setState(() {
          action = value;
        });
      },
      items: FilterAction.values.map((FilterAction action) {
        return DropdownMenuItem<FilterAction>(
            value: action, child: Text(action.toString()));
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Dialog(
      child: Container(
        width: 500,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Section(
              "term",
              child: TextField(
                decoration: InputDecoration(labelText: "enter search term"),
                controller: textEditingController,
                onChanged: (s) {
                  terms = s;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
            ),
            Section(
              "action",
              child: _buildActionSelect(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
            ),
            RaisedButton(
              child: Text("create"),
              onPressed: () {
                var res = TermsFilter(terms, action: action);
                Navigator.of(context).pop(res);
              },
            )
          ],
        ),
      ),
    );
  }
}
