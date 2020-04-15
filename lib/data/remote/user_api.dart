import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/model/provider_setting.dart';
import 'package:inked/data/model/user.dart';
import 'package:inked/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: BASE_API_URL)
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/user/me")
  Future<List<User>> getNews();

  @GET("/user/news/favorite")
  Future<List<News>> getFavoriteNewses();

  @POST("/user/news/favorite")
  Future<List<News>> postRegisterFavoriteNews(@Body() UpdateFavoriteNewsRequest request);

  @DELETE("/user/news/favorite")
  Future<List<News>> removeFavoriteNews(@Body() UpdateFavoriteNewsRequest request);


  @GET("/user/settings/provider")
  Future<List<ProviderSetting>> getProviderSettings();

  @POST("/user/settings/provider")
  Future<List<ProviderSetting>> postUpdateProviderSetting(@Body() ProviderSetting request);

}

@JsonSerializable()
class UpdateFavoriteNewsRequest {
  UpdateFavoriteNewsRequest(
      this.news);
  String news;

  factory UpdateFavoriteNewsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavoriteNewsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFavoriteNewsRequestToJson(this);
}
