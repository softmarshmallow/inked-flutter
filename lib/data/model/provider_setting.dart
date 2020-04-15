import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'provider_setting.g.dart';

@JsonSerializable()
class ProviderSetting extends Equatable{
  ProviderSetting({this.provider, this.availability});

  String provider;
  ProviderAvailabilityType availability;

  @JsonKey(ignore: true)
  get enabled{
    return availability != ProviderAvailabilityType.DISABLED;
    // MUTUAL & ENABLED -> enabled
  }

  factory ProviderSetting.fromJson(Map<String, dynamic> json) =>
      _$ProviderSettingFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderSettingToJson(this);

  @override
  List<Object> get props => [provider];
}

enum ProviderAvailabilityType {
  ENABLED,
  DISABLED,
  NEUTRAL,
}
