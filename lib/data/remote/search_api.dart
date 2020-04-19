
import 'package:dio/dio.dart';
import 'package:inked/remote_ui/layouts/search.layout.dart';
import 'package:inked/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: BASE_API_URL)
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  // remote ui
  @GET("/search")
  Future<List<SearchLayoutBase>> getBlank();

  @DELETE("/search/history")
  Future<void> removeSearchHistory(@Body() CrudSearchHistoryRequest request);

  @POST("/search/history")
  Future<void> createSearchHistory(@Body() CrudSearchHistoryRequest request);
}

@JsonSerializable()
class CrudSearchHistoryRequest{
  CrudSearchHistoryRequest(this.term);
  final String term;

  factory CrudSearchHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CrudSearchHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CrudSearchHistoryRequestToJson(this);
}