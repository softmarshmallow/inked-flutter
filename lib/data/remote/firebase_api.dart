import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inked/data/model/filter.dart';

abstract class BaseFirestoreApi<T> {

  BaseFirestoreApi(this.path);
  final String path;

  Future<T> get (String id) async {
    var res = await Firestore.instance.collection(path).document(id).snapshots().first;
    var downloaded = fromJson(res.data);
    seedId(downloaded, res.documentID);
    return downloaded;
  }


  Future<T> create(T record) async {
    var res = await Firestore.instance.collection(path).add(toJson(record));
    var uploaded = await res.snapshots().first;
    var downloaded = fromJson(uploaded.data);
    seedId(downloaded, uploaded.documentID);
    return downloaded;
  }
  Future<List<T>> list();
  Future<T> patch(String id, T record) async {
    var res = await Firestore.instance.collection(path).document(id).updateData(toJson(record));
    return record;
  }

  T fromJson(Map<String, dynamic> map);
  Map<String, dynamic> toJson(T data);
  seedId(T data, String id);
}


class TokenFilterFirestoreApi extends BaseFirestoreApi<TokenFilter>{
  TokenFilterFirestoreApi() : super("tokenfilters");

  @override
  Future<List<TokenFilter>> list() async{
    var res = await Firestore.instance.collection(path).snapshots().first;
    print(res);
    return [];
    // todo
  }

  @override
  TokenFilter fromJson(Map<String, dynamic> map) => TokenFilter.fromJson(map);

  @override
  Map<String, dynamic> toJson(TokenFilter t) => t.toJson();

  @override
  seedId(TokenFilter data, String id) => data.id = id;

}

class SingleTokenFilterLayerFirestoreApi extends BaseFirestoreApi<SingleTokenFilterLayer>{
  SingleTokenFilterLayerFirestoreApi() : super("single-token-filter-layers");

  @override
  SingleTokenFilterLayer fromJson(Map<String, dynamic> map) => SingleTokenFilterLayer.fromJson(map);

  @override
  Future<List<SingleTokenFilterLayer>> list() {
    // TODO: implement list
    throw UnimplementedError();
  }
  @override
  seedId(SingleTokenFilterLayer data, String id) => data.id = id;
  @override
  Map<String, dynamic> toJson(SingleTokenFilterLayer data) => data.toJson();
  
}