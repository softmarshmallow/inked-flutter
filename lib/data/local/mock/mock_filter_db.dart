import 'package:inked/data/local/mock/base.dart';
import 'package:inked/data/model/filter.dart';

class MockFilterDatabase extends BaseMockDatabase<TokenFilter>{

  static var filter = TokenFilter("dont show if photo", action: FilterAction.Hide, operation: OperationType.And, isRootFilter: true, isOn: true, filterLayers: [
    SingleTokenFilterLayer(token: "사진", scope: FilterScope.Title, match: FilterMatchType.Contains)
  ]);

  @override
  Future<TokenFilter> create(record) async{
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<TokenFilter> get(String re) async{
    return filter;
  }

  @override
  Future<List<TokenFilter>> list() async{
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<TokenFilter> patch(String re, record) async{
    // TODO: implement patch
    throw UnimplementedError();
  }

}