import 'package:inked/data/model/filter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News{
  News({this.title, this.content, this.provider, this.time});
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
  NewsFilterResult filterResult;
  @JsonKey(ignore: true)
  List<NewsFilterResult> filterResults = [];

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  String toString() => "${time.toIso8601String()}: $title \t$meta \t$filterResult";
}

@JsonSerializable()
class NewsMeta {
  NewsMeta();

  String source;
  String subject;
  List<String> tags;
  String status;
  List<String> categories;
  String category;
  DateTime crawlingAt;
  List<SpamMark> spamMarks;
  String summary;

  @JsonKey(ignore: true)
  bool get isSpam{
    for (var m in spamMarks){
      if (m.spam == SpamTag.SPAM){
        return true;
      }
    }
    return false;
  }

  factory NewsMeta.fromJson(Map<String, dynamic> json) =>
      _$NewsMetaFromJson(json);

  Map<String, dynamic> toJson() => _$NewsMetaToJson(this);

  @override
  String toString() {
    return "tags:$tags spam:$isSpam";
  }
}

@JsonSerializable()
class SpamMark {
  SpamMark();
  DateTime at;
  SpamTag spam;
  String reason;

  factory SpamMark.fromJson(Map<String, dynamic> json) =>
      _$SpamMarkFromJson(json);

  Map<String, dynamic> toJson() => _$SpamMarkToJson(this);
}

enum SpamTag {
  SPAM,
  NOTSPAM,
  UNTAGGED,
}
