// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.layout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLayoutBase _$SearchLayoutBaseFromJson(Map<String, dynamic> json) {
  return SearchLayoutBase()
    ..title = json['title'] == null
        ? null
        : Text.fromJson(json['title'] as Map<String, dynamic>)
    ..content = json['content'] == null
        ? null
        : View.fromJson(json['content'] as Map<String, dynamic>)
    ..avatar = json['avatar'] == null
        ? null
        : Avatar.fromJson(json['avatar'] as Map<String, dynamic>)
    ..meta = json['meta'] == null
        ? null
        : View.fromJson(json['meta'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SearchLayoutBaseToJson(SearchLayoutBase instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'avatar': instance.avatar,
      'meta': instance.meta,
    };
