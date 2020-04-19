// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrudSearchHistoryRequest _$CrudSearchHistoryRequestFromJson(
    Map<String, dynamic> json) {
  return CrudSearchHistoryRequest(
    json['term'] as String,
  );
}

Map<String, dynamic> _$CrudSearchHistoryRequestToJson(
        CrudSearchHistoryRequest instance) =>
    <String, dynamic>{
      'term': instance.term,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SearchApi implements SearchApi {
  _SearchApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://13.209.232.176:3000/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getBlank() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => SearchLayoutBase.fromJson(i as Map<String, dynamic>))
        .toList();
    return Future.value(value);
  }

  @override
  removeSearchHistory(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/search/history',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }

  @override
  createSearchHistory(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>('/search/history',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return Future.value(null);
  }
}
