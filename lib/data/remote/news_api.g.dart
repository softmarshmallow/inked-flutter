// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpamMarkRequest _$SpamMarkRequestFromJson(Map<String, dynamic> json) {
  return SpamMarkRequest(
    id: json['id'] as String,
    tag: _$enumDecodeNullable(_$SpamTagEnumMap, json['tag']),
    reason: json['reason'] as String,
  );
}

Map<String, dynamic> _$SpamMarkRequestToJson(SpamMarkRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': _$SpamTagEnumMap[instance.tag],
      'reason': instance.reason,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SpamTagEnumMap = {
  SpamTag.SPAM: 'SPAM',
  SpamTag.NOTSPAM: 'NOTSPAM',
  SpamTag.UNTAGGED: 'UNTAGGED',
};

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NewsApi implements NewsApi {
  _NewsApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://13.209.232.176:3000/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getNews() async {
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
  }

  @override
  getNewsItem(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/news/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = News.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getLastNews({page = '1', count = 100}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'page': page, 'count': count};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/news/recent',
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
  }

  @override
  getUntaggedNews() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/news/tag/spam?tag=UNTAGGED',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = News.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getSpammedNews() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/news/tag/spam?tag=SPAM',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = News.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getNotSpammedNews() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/news/tag/spam?tag=NOTSPAM',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = News.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  markSpamNews(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/news/tag/spam',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = News.fromJson(_result.data);
    return Future.value(value);
  }
}
