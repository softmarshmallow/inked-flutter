import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'news_filter_api.g.dart';

@RestApi(baseUrl: BASE_API_URL + "/filter/news")
abstract class NewsFilterApi {
  factory NewsFilterApi(Dio dio, {String baseUrl}) = _NewsFilterApi;

  @POST("/terms")
  Future<TermsFilter> createTermsFilter(@Body() TermsFilter update);

  @GET("/terms")
  Future<List<TermsFilter>> getAllTermsFilters();

  @GET("/terms/{id}")
  Future<TermsFilter> getSingleTermsFilter(@Path("id") String id);

  @DELETE("/terms/{id}")
  Future<TermsFilter> deleteSingleTermsFilter(@Path("id") String id);

  @PATCH("/terms/{id}")
  Future<TermsFilter> updateSingleTermsFilter(@Path("id") String id, @Body() TermsFilter update);
}
