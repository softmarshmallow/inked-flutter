// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..uid = json['uid'] as String
    ..robot = json['robot'] as bool
    ..settings = json['settings'] == null
        ? null
        : UserSettings.fromJson(json['settings'] as Map<String, dynamic>)
    ..registeredAt = json['registeredAt'] == null
        ? null
        : DateTime.parse(json['registeredAt'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uid': instance.uid,
      'robot': instance.robot,
      'settings': instance.settings,
      'registeredAt': instance.registeredAt?.toIso8601String(),
    };

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return UserSettings()
    ..id = json['id'] as String
    ..favoriteNewses = (json['favoriteNewses'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'favoriteNewses': instance.favoriteNewses,
    };
