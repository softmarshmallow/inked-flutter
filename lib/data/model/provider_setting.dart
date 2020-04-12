import 'package:json_annotation/json_annotation.dart';

part 'provider_setting.g.dart';

@JsonSerializable()
class ProviderSetting{
  ProviderSetting({this.provider, this.enabled});

  String provider;
  bool enabled;


  factory ProviderSetting.fromJson(Map<String, dynamic> json) =>
      _$ProviderSettingFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderSettingToJson(this);
}