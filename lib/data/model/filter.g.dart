// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenFilter _$TokenFilterFromJson(Map<String, dynamic> json) {
  return TokenFilter(
    json['name'] as String,
    action: _$enumDecodeNullable(_$FilterActionEnumMap, json['action']),
    operation: _$enumDecodeNullable(_$OperationTypeEnumMap, json['operation']),
    isRootFilter: json['isRootFilter'] as bool,
    isOn: json['isOn'] as bool,
    filterLayers: (json['filterLayers'] as List)
        ?.map((e) => e == null
            ? null
            : SingleTokenFilterLayer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extraFilters: (json['extraFilters'] as List)
        ?.map((e) =>
            e == null ? null : TokenFilter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TokenFilterToJson(TokenFilter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'action': _$FilterActionEnumMap[instance.action],
      'filterLayers': instance.filterLayers,
      'extraFilters': instance.extraFilters,
      'operation': _$OperationTypeEnumMap[instance.operation],
      'isRootFilter': instance.isRootFilter,
      'isOn': instance.isOn,
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

const _$FilterActionEnumMap = {
  FilterAction.ALERT: 'ALERT',
  FilterAction.NOTIFY: 'NOTIFY',
  FilterAction.HIGHLIGHT: 'HIGHLIGHT',
  FilterAction.SILENCE: 'SILENCE',
  FilterAction.HIDE: 'HIDE',
  FilterAction.IGNORE: 'IGNORE',
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
    match: _$enumDecodeNullable(_$FilterMatchTypeEnumMap, json['match']),
  );
}

Map<String, dynamic> _$SingleTokenFilterLayerToJson(
        SingleTokenFilterLayer instance) =>
    <String, dynamic>{
      'token': instance.token,
      'scope': _$FilterScopeEnumMap[instance.scope],
      'match': _$FilterMatchTypeEnumMap[instance.match],
    };

const _$FilterScopeEnumMap = {
  FilterScope.Title: 'Title',
  FilterScope.Body: 'Body',
};

const _$FilterMatchTypeEnumMap = {
  FilterMatchType.Contains: 'Contains',
  FilterMatchType.Matches: 'Matches',
  FilterMatchType.NotContains: 'NotContains',
  FilterMatchType.NotMatches: 'NotMatches',
};

TermsFilter _$TermsFilterFromJson(Map<String, dynamic> json) {
  return TermsFilter(
    json['terms'] as String,
    action: _$enumDecodeNullable(_$FilterActionEnumMap, json['action']),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$TermsFilterToJson(TermsFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': _$FilterActionEnumMap[instance.action],
      'terms': instance.terms,
    };
