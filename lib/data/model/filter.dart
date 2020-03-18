import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

/// not using local db. using simple persistence data, since so. we use id as date mills

@JsonSerializable()
class TokenFilter{
  TokenFilter();
  int id = DateTime.now().millisecondsSinceEpoch;
  String name;
  FilterType type = FilterType.Notify;
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
  SingleTokenFilterLayer({@required this.token, @required this.scope});
  int id = DateTime.now().millisecondsSinceEpoch;
  String name;
  String token;
  FilterScope scope;

  factory SingleTokenFilterLayer.fromJson(Map<String, dynamic> json) => _$SingleTokenFilterLayerFromJson(json);
  Map<String, dynamic> toJson() => _$SingleTokenFilterLayerToJson(this);
}


enum OperationType{
  And,
  Or
}

enum MatchType{
  Contains,
  Matches
}


enum FilterType{
  Ignore,
  Notify
}

enum FilterScope{
  Title,
  Body
}