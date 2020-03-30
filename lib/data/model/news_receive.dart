import 'package:json_annotation/json_annotation.dart';

import 'news.dart';

part 'news_receive.g.dart';

@JsonSerializable()
class NewsReceiveEvent {
  NewsReceiveEvent();
  NewsRefreshType type;
  News data;

  factory NewsReceiveEvent.fromJson(Map<String, dynamic> json) =>
      _$NewsReceiveEventFromJson(json);

  Map<String, dynamic> toJson() => _$NewsReceiveEventToJson(this);
}

enum NewsRefreshType {
  NEW,
  REPLACED,
  ANALYZED,
}
