import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

/// not using local db. using simple persistence data, since so. we use id as date mills

@JsonSerializable()
class TokenFilter{
  TokenFilter(this.name, {this.action, this.operation, this.isRootFilter, this.isOn});

  @JsonKey(ignore: true)
  String id = DateTime.now().toIso8601String();
  String name = "untitled";
  FilterAction action = FilterAction.Notify;
  List<SingleTokenFilterLayer> filterLayers = [];
  List<TokenFilter> extraFilters = [];
  OperationType operation = OperationType.And;
  bool isRootFilter = true;
  bool isOn = true;

  factory TokenFilter.fromJson(Map<String, dynamic> json) => _$TokenFilterFromJson(json);
  Map<String, dynamic> toJson() => _$TokenFilterToJson(this);
}

@JsonSerializable()
class SingleTokenFilterLayer {
  SingleTokenFilterLayer({@required this.token, @required this.scope, this.match});

  @JsonKey(ignore: true)
  String id = DateTime.now().toIso8601String();
  String token;
  FilterScope scope = FilterScope.Title;
  FilterMatchType match = FilterMatchType.Matches;

  factory SingleTokenFilterLayer.fromJson(Map<String, dynamic> json) => _$SingleTokenFilterLayerFromJson(json);
  Map<String, dynamic> toJson() => _$SingleTokenFilterLayerToJson(this);

  @override
  String toString() => "$token in $scope as $match";
}


enum OperationType{
  And,
  Or
}

enum FilterMatchType{
  Contains,
  Matches,
  NotContains,
  MotMatches,
}


enum FilterAction{
  Hide,
  Notify
}

enum FilterScope{
  Title,
  Body
}