// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NewsApi implements NewsApi {
  _NewsApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://localhost:8000/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getNews() async {
    try{
      const _extra = <String, dynamic>{};
      final queryParameters = <String, dynamic>{};
      final _data = <String, dynamic>{};
      final Response<List<dynamic>> _result = await _dio.request('/news',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'GET',
              headers: <String, dynamic>{},
              extra: _extra,
              baseUrl: baseUrl),
          data: _data);
      var value = _result.data
          .map((dynamic i) => News.fromJson(i as Map<String, dynamic>))
          .toList();
      return Future.value(value);
    }catch(e){
      print(e);
    }
    return [];

  }
}
