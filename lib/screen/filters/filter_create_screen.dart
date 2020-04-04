import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/dialogs/edit_token_filter_layer_dialog.dart';
import 'package:inked/widget/section.dart';
import 'package:inked/widget/singletokenfilterlayer_listtile.dart';

class FilterCreateScreen extends StatefulWidget {
  static const routeName = "/settings/filter/new";

  @override
  State<StatefulWidget> createState() => _FilterCreateScreenState();
}

class _FilterCreateScreenState extends State<FilterCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TokenFilter filter = new TokenFilter("untitled",
      action: FilterAction.Hide, isOn: true, isRootFilter: true, filterLayers: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("create new filter"),
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildFormSection(context),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 24),
                  child: _buildSummaryText(),
                ),
//                BlocProvider(
//                    create: (context) {
//                      return FilterTesterBloc();
//                    },
//                    child: TokenFilterTester()),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
      ),
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            onChanged: (t) {
              setState(() {
                filter.name = t;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'E.g. (removal spam basics in title)',
                labelText: "Filter name"),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ListView.builder(
              itemBuilder: (c, i) {
                final data = filter.filterLayers[i];
                return SingleTokenLayerListTile(
                  data,
                  trails: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          filter.filterLayers.remove(data);
                        });
                      },
                    )
                  ],
                );
              },
              itemCount: filter.filterLayers.length,
              shrinkWrap: true),
          RaisedButton(
            child: Text("create new layer"),
            onPressed: () async {
              var layer = await showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      EditTokenFilterLayerDialog());
              if (layer != null) {
                print('received create layer >> $layer');
                setState(() {
                  filter.filterLayers.add(layer);
                });
              }
            },
          ),
          Section(
            "logic",
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('And'),
                  leading: Radio<OperationType>(
                    value: OperationType.And,
                    groupValue: filter.operation,
                    onChanged: (value) {
                      setState(() {
                        filter.operation = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Or'),
                  leading: Radio<OperationType>(
                    value: OperationType.Or,
                    groupValue: filter.operation,
                    onChanged: (value) {
                      setState(() {
                        filter.operation = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Section(
            "root filter",
            child: CheckboxListTile(
              title: Text("use this as root filter"),
              value: filter.isRootFilter,
              onChanged: (v) {
                setState(() {
                  filter.isRootFilter = v;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          filter.isRootFilter
              ? Section(
                  "action",
                  child: DropdownButton(
                    value: filter.action,
                    onChanged: (FilterAction value) {
                      setState(() {
                        filter.action = value;
                      });
                    },
                    items: FilterAction.values.map((FilterAction action) {
                      return DropdownMenuItem<FilterAction>(
                          value: action, child: Text(action.toString()));
                    }).toList(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildSummaryText() {
    return Text("""
you are creating new filter named "${filter.name}"
which does ${filter.action}
when ${filter.filterLayers.map((e) => "${e.token} does ${e.match} in ${e.scope} ${filter.operation}\n")}
""");
  }
}
