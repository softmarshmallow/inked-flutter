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
      {@Query("page") String page = '1', @Query("count") int count=100});

  @GET("/news/tag/spam")
  Future<News> getSpamNews();

  @PATCH("/news/tag/spam")
  Future<int> markSpamNews(@Body() SpamMarkRequest req);
}

@JsonSerializable()
class SpamMarkRequest{
  SpamMarkRequest({@required this.id,@required  this.is_spam});
  String id;
  bool is_spam;

  factory SpamMarkRequest.fromJson(Map<String, dynamic> json) => _$SpamMarkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SpamMarkRequestToJson(this);
}