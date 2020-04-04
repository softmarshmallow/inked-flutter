import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/screen/filters/filter_create_screen.dart';

class FilterSettingsScreen extends StatefulWidget {
  static const String routeName = "/settings/filter/basics";

  @override
  State<StatefulWidget> createState() => _FilterSettingsScreen();
}

class _FilterSettingsScreen extends State<FilterSettingsScreen> {
  bool sort;
  List<SingleTokenFilterLayer> filters;

  @override
  void initState() {
    sort = false;
    filters = [
      SingleTokenFilterLayer(
        token: "예) [포토]",
        scope: FilterScope.Title,
//        type: FilterType.Ignore,
      ),
      SingleTokenFilterLayer(
        token: "예) [연예]",
        scope: FilterScope.Title,
//        type: FilterType.Ignore,
      ),
    ];
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("basic token filter"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
//        child: _buildFilterDataTable(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showCreateTokenFilterDialog,
      ),
    );
  }


  Widget _buildFilterDataTable() {

    DataRow _buildRow(SingleTokenFilterLayer filter) {
      return DataRow(cells: [
        DataCell(Text(filter.token)),
//        DataCell(Text(filter.type.toString())),
        DataCell(Text(filter.scope.toString())),
        DataCell(Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.remove_circle), onPressed: () {
              showDialog(context: context, builder: (context) => AlertDialog(
                title: Text("remove token filter?"), actions: <Widget>[
                FlatButton(child: Text("cancel"), onPressed: (){Navigator.of(context).pop();},),
                FlatButton(child: Text("remove"), onPressed: (){
                  // todo - implement remove
                },),
              ],
              ));

            },),
          ],
        )),
      ]);
    }

    List<DataRow> _buildRows() {
      List<DataRow> result = [];
      filters.forEach((d) {
        result.add(_buildRow(d));
      });
      return result;
    }

    return DataTable(
      sortAscending: sort,
      sortColumnIndex: 0,
      columns: [
        DataColumn(label: Text("token"), numeric: false, onSort: (i, b) {
          setState(() {
            sort =! sort;
          });
          if (i == 0) {
            if (b) {
              filters.sort((a, b) => a.token.compareTo(b.token));
            } else {
              filters.sort((a, b) => b.token.compareTo(a.token));
            }
          }
        },),
        DataColumn(label: Text("type"), numeric: true),
        DataColumn(label: Text("scope"), numeric: true),
        DataColumn(label: Text("actions")),
      ],
      rows: _buildRows(),
    );
  }

  _showCreateTokenFilterDialog() {
    Navigator.of(context).pushNamed(FilterCreateScreen.routeName);
  }
}
