import 'package:inked/data/model/filter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News{

  News({this.title, this.content, this.provider, this.time, this.tags});
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'provider')
  String provider;
  @JsonKey(name: 'originUrl')
  String originUrl;
  @JsonKey(name: 'time')
  DateTime time = DateTime.now();

  @JsonKey(name: 'meta')
  NewsMeta meta;

  @JsonKey(ignore: true)
  List<String> tags = [];

  @JsonKey(ignore: true)
  FilterResult filterResult;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  String toString() => "${time.toIso8601String()}: $title";
}


@JsonSerializable()
class NewsMeta{
  NewsMeta();
  String source;
  String subject;
  List<String> tags;
  String status;
  List<String> categories;
  String category;
  DateTime crawledAt;
  String summary;

  factory NewsMeta.fromJson(Map<String, dynamic> json) => _$NewsMetaFromJson(json);
  Map<String, dynamic> toJson() => _$NewsMetaToJson(this);
}