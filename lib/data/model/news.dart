import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News{

  News({this.title, this.content, this.provider, this.time, this.tags});

  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'body_html')
  String content;
  @JsonKey(name: 'provider')
  String provider;
  @JsonKey(name: 'origin_url')
  String originUrl;
  @JsonKey(name: 'time')
  DateTime time;
  @JsonKey(ignore: true)
  List<String> tags = [];

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

}