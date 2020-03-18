import 'package:inked/data/model/filter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceBasedDatabase<IdType, Model> {
  List<Model> source = [];
  String table;

  PreferenceBasedDatabase() {
    load();
  }

  IdType getRecordId(Model record);

  Future<List<Model>> load() async {
    final prefs = await SharedPreferences.getInstance();
    source = prefs.getStringList(table) ?? [];
    return source;
  }

  Future<Model> add(Model record);

  remove(IdType record);

  removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(table);
  }
}

class FilterDB extends PreferenceBasedDatabase<int, TokenFilter> {
  String table = "filter";

  @override
  Future<TokenFilter> add(TokenFilter record) async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  remove(int record) async {
    final prefs = await SharedPreferences.getInstance();
    source.removeWhere((element) => element.id == record);
  }

  @override
  int getRecordId(TokenFilter record) => record.id;

//
//// set value
//  prefs.setInt('counter', counter);
//
//
//
//  final prefs = await SharedPreferences.getInstance();
//
//// Try reading data from the counter key. If it doesn't exist, return 0.
//  final counter = prefs.getInt('counter') ?? 0;

}
