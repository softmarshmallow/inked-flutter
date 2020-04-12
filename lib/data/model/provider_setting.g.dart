// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderSetting _$ProviderSettingFromJson(Map<String, dynamic> json) {
  return ProviderSetting()
    ..provider = json['provider'] as String
    ..enabled = json['enabled'] as bool;
}

Map<String, dynamic> _$ProviderSettingToJson(ProviderSetting instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'enabled': instance.enabled,
    };
