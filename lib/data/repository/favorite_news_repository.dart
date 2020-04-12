

import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/user_api.dart';
import 'package:inked/data/repository/base.dart';

class FavoriteNewsRepository extends BaseRepository<News>{
  // region singleton
  static final FavoriteNewsRepository _singleton = FavoriteNewsRepository._internal();
  factory FavoriteNewsRepository() {
    return _singleton;
  }
  FavoriteNewsRepository._internal();
  // endregion

  @override
  bool add(News data) {
    DATA.add(data);
  }

  @override
  set(List<News> data) {
    DATA = data;
  }

  bool isFavorite(News news){
    for (var n in DATA){
      if (n.id == news.id) {
        return true;
      }
    }
    return false;
  }

  @override
  bool remove(News data) {
    try{
      DATA.removeWhere((element) {
        return data.id == element.id;
      });
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  seed() async {
    var newes = await UserApi(RemoteApiManager().getDio()).getFavoriteNewses();
    set(newes);
  }
}