import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/widget/section.dart';

class EditTokenFilterLayerDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditTokenFilterLayerDialogState();
}

class _EditTokenFilterLayerDialogState
    extends State<EditTokenFilterLayerDialog> {
  SingleTokenFilterLayer layer = new SingleTokenFilterLayer(
      token: null, scope: FilterScope.Title, match: FilterMatchType.Matches);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("layer"),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                autofocus: true,
                decoration: InputDecoration(labelText: "token"),
                onChanged: (t) {
                  setState(() {
                    layer.token = t;
                  });
                },
              ),
              Section(
                "filter type",
                child: DropdownButton(
                  value: layer.match,
                  onChanged: (FilterMatchType value) {
                    setState(() {
                      layer.match = value;
                    });
                  },
                  items: FilterMatchType.values.map((FilterMatchType match) {
                    return DropdownMenuItem<FilterMatchType>(
                        value: match, child: Text(match.toString()));
                  }).toList(),
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
                        groupValue: layer.scope,
                        onChanged: (value) {
                          setState(() {
                            layer.scope = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('content'),
                      leading: Radio<FilterScope>(
                        value: FilterScope.Body,
                        groupValue: layer.scope,
                        onChanged: (value) {
                          setState(() {
                            layer.scope = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "token \"${layer.token}\" should ${layer.match} in ${layer.scope}",
                style: Theme.of(context).textTheme.caption,
              )
            ],
          )),
      actions: <Widget>[
        RaisedButton(
          child: Text("ADD"),
          onPressed: () {
            var validated = _formKey.currentState.validate();
            if (validated) {
              Navigator.of(context).pop(layer);
            }
          },
        ),
      ],
    );
  }
}
