import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/widget/section.dart';

class EditTokenFilterLayerDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditTokenFilterLayerDialogState();
}

class _EditTokenFilterLayerDialogState
    extends State<EditTokenFilterLayerDialog> {
  SingleTokenFilterLayer layer =
      new SingleTokenFilterLayer(token: null, scope: FilterScope.Title);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("layer"),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Section("filter type",
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('exactly matches'),
                        leading: Radio(
                          value: MatchType.Matches,
                          groupValue: layer.match,
                          onChanged: (value) {
                            setState(() {
                              layer.match = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('contains'),
                        leading: Radio(
                          value: MatchType.Contains,
                          groupValue: layer.match,
                          onChanged: (value) {
                            setState(() {
                              layer.match = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
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
                  "token \"${layer.token}\" should ${layer.match} in ${layer.scope}", style: Theme.of(context).textTheme.caption,)
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
