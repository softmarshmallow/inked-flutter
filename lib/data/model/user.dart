
import 'package:inked/data/model/news.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  User();
  String id;
  String name;
  String uid;
  bool robot;
  UserSettings settings;
  DateTime registeredAt;


  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserSettings{
  UserSettings();

  String id;
  List<News> favoriteNewses;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}
