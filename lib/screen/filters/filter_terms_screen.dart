import 'package:after_layout/after_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/remote/news_filter_api.dart';
import 'package:inked/data/repository/news_filter_repositry.dart';
import 'package:inked/dialogs/edit_terms_filter_dialog.dart';
import 'package:inked/widget/section.dart';

class TermsFilterScreen extends StatefulWidget {
  static const String routeName = "/settings/filter/terms";

  @override
  State<StatefulWidget> createState() => _TermsFilterScreenState();
}

class _TermsFilterScreenState extends State<TermsFilterScreen>
    with AfterLayoutMixin<TermsFilterScreen> {
  NewsFilterApi _api;
  List<TermsFilter> filters = [];
  TermsFilter currentFilter;
  NewsFilterRepository repository = NewsFilterRepository();

  _TermsFilterScreenState() {
    _api =
        NewsFilterApi(Dio()); //, baseUrl: "http://localhost:3000/api/filter/news/"
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    _refresh();
  }

  _refresh() async {
    var filters = await _api.getAllTermsFilters();
    setState(() {
      this.filters = filters;
    });
    repository.set(filters);
  }

  _updateOne(TermsFilter filter) async {
    await _api.updateSingleTermsFilter(filter.id, filter);
    _refresh();
  }

  _createOne(TermsFilter filter) async {
    await _api.createTermsFilter(filter);
    _refresh();
  }

  _deleteOne(String id) async {
    await _api.deleteSingleTermsFilter(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("terms filter"),
      ),
      body: Column(
        children: <Widget>[_buildFilterList()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showCreateTermsFilterDialog,
      ),
    );
  }

  _showCreateTermsFilterDialog() async {
    var res = await showDialog(context: context, child: EditTermsFilterDialog());
    if (res != null) {
      _createOne(res);
    }
  }

  Widget _buildFilterList() {
    if (filters.length > 0) {
      return ListView.builder(
        itemBuilder: (c, i) {
          var filter = filters[i];
          return TermsFilterListItem(filter, onRemove: _deleteOne,);
        },
        itemCount: filters.length,
        shrinkWrap: true,
      );
    } else {
      return Text("no filter to display..");
    }
  }
}

class TermsFilterListItem extends StatelessWidget {
  final TermsFilter _termsFilter;
  final Function(String id) onRemove;
  TermsFilterListItem(this._termsFilter, {this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_termsFilter.terms),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: () {
          onRemove?.call(_termsFilter.id);
        },
      ),
    );
  }
}
