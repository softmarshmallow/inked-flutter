// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderSetting _$ProviderSettingFromJson(Map<String, dynamic> json) {
  return ProviderSetting(
    provider: json['provider'] as String,
    availability: _$enumDecodeNullable(
        _$ProviderAvailabilityTypeEnumMap, json['availability']),
  );
}

Map<String, dynamic> _$ProviderSettingToJson(ProviderSetting instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'availability': _$ProviderAvailabilityTypeEnumMap[instance.availability],
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

const _$ProviderAvailabilityTypeEnumMap = {
  ProviderAvailabilityType.ENABLED: 'ENABLED',
  ProviderAvailabilityType.DISABLED: 'DISABLED',
  ProviderAvailabilityType.NEUTRAL: 'NEUTRAL',
};
