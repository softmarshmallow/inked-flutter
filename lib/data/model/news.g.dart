// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    title: json['title'] as String,
    content: json['content'] as String,
    provider: json['provider'] as String,
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
  )
    ..id = json['id'] as String
    ..originUrl = json['originUrl'] as String
    ..meta = json['meta'] == null
        ? null
        : NewsMeta.fromJson(json['meta'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'provider': instance.provider,
      'originUrl': instance.originUrl,
      'time': instance.time?.toIso8601String(),
      'meta': instance.meta,
    };

NewsMeta _$NewsMetaFromJson(Map<String, dynamic> json) {
  return NewsMeta()
    ..source = json['source'] as String
    ..subject = json['subject'] as String
    ..tags = (json['tags'] as List)?.map((e) => e as String)?.toList()
    ..status = json['status'] as String
    ..categories =
        (json['categories'] as List)?.map((e) => e as String)?.toList()
    ..category = json['category'] as String
    ..crawledAt = json['crawledAt'] == null
        ? null
        : DateTime.parse(json['crawledAt'] as String)
    ..spamMarks = (json['spamMarks'] as List)
        ?.map((e) =>
            e == null ? null : SpamMark.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..summary = json['summary'] as String;
}

Map<String, dynamic> _$NewsMetaToJson(NewsMeta instance) => <String, dynamic>{
      'source': instance.source,
      'subject': instance.subject,
      'tags': instance.tags,
      'status': instance.status,
      'categories': instance.categories,
      'category': instance.category,
      'crawledAt': instance.crawledAt?.toIso8601String(),
      'spamMarks': instance.spamMarks,
      'summary': instance.summary,
    };

SpamMark _$SpamMarkFromJson(Map<String, dynamic> json) {
  return SpamMark()
    ..at = json['at'] == null ? null : DateTime.parse(json['at'] as String)
    ..spam = _$enumDecodeNullable(_$SpamTagEnumMap, json['spam'])
    ..reason = json['reason'] as String;
}

Map<String, dynamic> _$SpamMarkToJson(SpamMark instance) => <String, dynamic>{
      'at': instance.at?.toIso8601String(),
      'spam': _$SpamTagEnumMap[instance.spam],
      'reason': instance.reason,
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

const _$SpamTagEnumMap = {
  SpamTag.SPAM: 'SPAM',
  SpamTag.NOTSPAM: 'NOTSPAM',
  SpamTag.UNTAGGED: 'UNTAGGED',
};
