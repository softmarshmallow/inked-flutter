import 'package:inked/data/local/mock/base.dart';
import 'package:inked/data/model/filter.dart';

class MockFilterDatabase extends BaseMockDatabase<TokenFilter>{

//  static var spams
  
  static var photoFilter = TokenFilter("dont show if photo", action: FilterAction.Hide, operation: OperationType.Or, isRootFilter: true, isOn: true, filterLayers: [
    SingleTokenFilterLayer(token: "사진", scope: FilterScope.Title, match: FilterMatchType.Contains),
    SingleTokenFilterLayer(token: "포토", scope: FilterScope.Title, match: FilterMatchType.Contains),
    SingleTokenFilterLayer(token: "<img", scope: FilterScope.Body, match: FilterMatchType.Contains),
  ]);

  static var miscSpamFilter = TokenFilter("dont show if misc spam", action: FilterAction.Hide, operation: OperationType.Or, isRootFilter: true, isOn: true, filterLayers: [
    SingleTokenFilterLayer(token: "날씨", scope: FilterScope.Title, match: FilterMatchType.Contains),
    SingleTokenFilterLayer(token: "기고", scope: FilterScope.Title, match: FilterMatchType.Contains),
    SingleTokenFilterLayer(token: "n번방", scope: FilterScope.Title, match: FilterMatchType.Contains),
    SingleTokenFilterLayer(token: "아슬아슬", scope: FilterScope.Title, match: FilterMatchType.Contains),
  ]);

  static var mainFilter = TokenFilter("default smap removal", action: FilterAction.Hide, operation: OperationType.Or, isRootFilter: true, isOn: true, filterLayers: [], extraFilters: [
    photoFilter,
    miscSpamFilter
  ]);

  @override
  Future<TokenFilter> create(record) async{
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<TokenFilter> get(String re) async{
    return photoFilter;
  }

  @override
  Future<List<TokenFilter>> list() async{
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<TokenFilter> update(String re, record) async{
    // TODO: implement patch
    throw UnimplementedError();
  }

}