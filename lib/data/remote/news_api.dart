import 'package:dio/dio.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class NewsApi {
  factory NewsApi(Dio dio, {String baseUrl}) = _NewsApi;

  @GET("/news")
  Future<List<News>> getNews();

  @GET("/news/{id}")
  Future<List<News>> getNewsItem(@Path("id") String id);

  @GET("/news/recent")
  Future<List<News>> getLastNews(
      {@Query("page") String page = '1', @Query("count") int count=100});
}