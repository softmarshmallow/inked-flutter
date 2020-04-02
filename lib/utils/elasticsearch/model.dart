
import 'package:inked/data/model/news.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';
@JsonSerializable()
class DocumentResult<T>{
  DocumentResult();

  @JsonKey(name: "_index")
  String index;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "_score")
  num score;

}


@JsonSerializable()
class NewsDocumentResult extends DocumentResult<News>{
  NewsDocumentResult();

  @JsonKey(name: "_source")
  News source;

  @JsonKey(name: "highlight")
  NewsHighlights highlight;
  factory NewsDocumentResult.fromJson(Map<String, dynamic> json) =>
      _$NewsDocumentResultFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDocumentResultToJson(this);
}


@JsonSerializable()
class NewsHighlights{
  NewsHighlights();
  List<String> content;
  List<String> title;

  factory NewsHighlights.fromJson(Map<String, dynamic> json) =>
      _$NewsHighlightsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsHighlightsToJson(this);
}