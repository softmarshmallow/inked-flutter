import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api.g.dart';

@RestApi(baseUrl: BASE_API_URL)
abstract class NewsApi {
  factory NewsApi(Dio dio, {String baseUrl}) = _NewsApi;

  @GET("/news")
  Future<List<News>> getNews();

  @GET("/news/{id}")
  Future<News> getNewsItem(@Path("id") String id);

  @GET("/news/recent")
  Future<List<News>> getLastNews(
      {@Query("page") String page = '1', @Query("count") int count = 100});

  @GET("/news/tag/spam?tag=UNTAGGED")
  Future<News> getUntaggedNews();

  @GET("/news/tag/spam?tag=SPAM")
  Future<News> getSpammedNews();

  @GET("/news/tag/spam?tag=NOTSPAM")
  Future<News> getNotSpammedNews();

  @PATCH("/news/tag/spam")
  Future<News> markSpamNews(@Body() SpamMarkRequest req);
}

@JsonSerializable()
class SpamMarkRequest {
  SpamMarkRequest(
      {@required this.id, @required this.tag, @required this.reason});
  String id;
  SpamTag tag;
  String reason;

  factory SpamMarkRequest.fromJson(Map<String, dynamic> json) =>
      _$SpamMarkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SpamMarkRequestToJson(this);
}
