library ui;

import 'package:json_annotation/json_annotation.dart';
part 'index.g.dart';

@JsonSerializable()
class View{
  View();

  factory View.fromJson(Map<String, dynamic> json) =>
      _$ViewFromJson(json);

  Map<String, dynamic> toJson() => _$ViewToJson(this);
}

@JsonSerializable()
class Text extends View{
  Text(this.text);
  final String text;

  factory Text.fromJson(Map<String, dynamic> json) =>
      _$TextFromJson(json);

  Map<String, dynamic> toJson() => _$TextToJson(this);
}

@JsonSerializable()
class Avatar extends View{
  Avatar(this.source);
  final String source;

  factory Avatar.fromJson(Map<String, dynamic> json) =>
      _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}