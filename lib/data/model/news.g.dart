// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    title: json['title'] as String,
    content: json['body_html'] as String,
    provider: json['provider'] as String,
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
  )
    ..id = json['article_id'] as String
    ..originUrl = json['origin_url'] as String;
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'article_id': instance.id,
      'title': instance.title,
      'body_html': instance.content,
      'provider': instance.provider,
      'origin_url': instance.originUrl,
      'time': instance.time?.toIso8601String(),
    };
