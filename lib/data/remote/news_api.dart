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
}