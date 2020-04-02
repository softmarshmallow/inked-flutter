// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResult<T> _$DocumentResultFromJson<T>(Map<String, dynamic> json) {
  return DocumentResult<T>()
    ..index = json['_index'] as String
    ..id = json['_id'] as String
    ..score = json['_score'] as num;
}

Map<String, dynamic> _$DocumentResultToJson<T>(DocumentResult<T> instance) =>
    <String, dynamic>{
      '_index': instance.index,
      '_id': instance.id,
      '_score': instance.score,
    };

NewsDocumentResult _$NewsDocumentResultFromJson(Map<String, dynamic> json) {
  return NewsDocumentResult()
    ..index = json['_index'] as String
    ..id = json['_id'] as String
    ..score = json['_score'] as num
    ..source = json['_source'] == null
        ? null
        : News.fromJson(json['_source'] as Map<String, dynamic>)
    ..highlight = json['highlight'] == null
        ? null
        : NewsHighlights.fromJson(json['highlight'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewsDocumentResultToJson(NewsDocumentResult instance) =>
    <String, dynamic>{
      '_index': instance.index,
      '_id': instance.id,
      '_score': instance.score,
      '_source': instance.source,
      'highlight': instance.highlight,
    };

NewsHighlights _$NewsHighlightsFromJson(Map<String, dynamic> json) {
  return NewsHighlights()
    ..content = (json['content'] as List)?.map((e) => e as String)?.toList()
    ..title = (json['title'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$NewsHighlightsToJson(NewsHighlights instance) =>
    <String, dynamic>{
      'content': instance.content,
      'title': instance.title,
    };
