// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenFilter _$TokenFilterFromJson(Map<String, dynamic> json) {
  return TokenFilter()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..type = _$enumDecodeNullable(_$FilterTypeEnumMap, json['type'])
    ..filterLayers = (json['filterLayers'] as List)
        ?.map((e) => e == null
            ? null
            : SingleTokenFilterLayer.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..extraFilters = (json['extraFilters'] as List)
        ?.map((e) =>
            e == null ? null : TokenFilter.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..operation =
        _$enumDecodeNullable(_$OperationTypeEnumMap, json['operation']);
}

Map<String, dynamic> _$TokenFilterToJson(TokenFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$FilterTypeEnumMap[instance.type],
      'filterLayers': instance.filterLayers,
      'extraFilters': instance.extraFilters,
      'operation': _$OperationTypeEnumMap[instance.operation],
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

const _$FilterTypeEnumMap = {
  FilterType.Ignore: 'Ignore',
  FilterType.Notify: 'Notify',
};

const _$OperationTypeEnumMap = {
  OperationType.And: 'And',
  OperationType.Or: 'Or',
};

SingleTokenFilterLayer _$SingleTokenFilterLayerFromJson(
    Map<String, dynamic> json) {
  return SingleTokenFilterLayer(
    token: json['token'] as String,
    scope: _$enumDecodeNullable(_$FilterScopeEnumMap, json['scope']),
  )
    ..id = json['id'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$SingleTokenFilterLayerToJson(
        SingleTokenFilterLayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'token': instance.token,
      'scope': _$FilterScopeEnumMap[instance.scope],
    };

const _$FilterScopeEnumMap = {
  FilterScope.Title: 'Title',
  FilterScope.Body: 'Body',
};
