import 'package:dio/dio.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/remote/news_filter_api.dart';
import 'package:inked/data/repository/base.dart';


class NewsFilterRepository extends BaseRepository<TermsFilter> {
  // region singleton
  static final NewsFilterRepository _singleton = NewsFilterRepository._internal();
  factory NewsFilterRepository() {
    return _singleton;
  }
  NewsFilterRepository._internal();
  // endregion

  seed(){
    NewsFilterApi(Dio()).getAllTermsFilters().then((value) => {
      DATA = value
    });
  }

  List<TermsFilter> DATA = [];

  set(List<TermsFilter> filters) {
    DATA = filters;
  }

  @override
  add(TermsFilter data) {
    throw UnimplementedError();
  }
}
