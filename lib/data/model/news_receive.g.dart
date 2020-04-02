// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsReceiveEvent _$NewsReceiveEventFromJson(Map<String, dynamic> json) {
  return NewsReceiveEvent()
    ..type = _$enumDecodeNullable(_$NewsRefreshTypeEnumMap, json['type'])
    ..data = json['data'] == null
        ? null
        : News.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewsReceiveEventToJson(NewsReceiveEvent instance) =>
    <String, dynamic>{
      'type': _$NewsRefreshTypeEnumMap[instance.type],
      'data': instance.data,
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

const _$NewsRefreshTypeEnumMap = {
  NewsRefreshType.NEW: 'NEW',
  NewsRefreshType.REPLACED: 'REPLACED',
  NewsRefreshType.ANALYZED: 'ANALYZED',
};
