import 'package:flutter/foundation.dart';
import 'package:inked/data/model/base.dart';
import 'package:inked/utils/elasticsearch/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

/// not using local db. using simple persistence data, since so. we use id as date mills

abstract class NewsFilter{
  String name;
  FilterAction action;
}


@JsonSerializable()
class TokenFilter extends NewsFilter implements IFirebaseModel{
  TokenFilter(this.name, {this.action, this.operation, this.isRootFilter, this.isOn, this.filterLayers, this.extraFilters});

  @JsonKey(ignore: true)
  String id = DateTime.now().toIso8601String();
  String name = "untitled";
  FilterAction action;
  List<SingleTokenFilterLayer> filterLayers = [];

  List<TokenFilter> extraFilters = [];
  //  @JsonKey(ignore: true)
  // todo support relational
  //  List<DocumentReference> extraFiltersReferences = [];

  OperationType operation = OperationType.And;
  bool isRootFilter = true;
  bool isOn = true;

  factory TokenFilter.fromJson(Map<String, dynamic> json) => _$TokenFilterFromJson(json);
  Map<String, dynamic> toJson() => _$TokenFilterToJson(this);
}

@JsonSerializable()
class SingleTokenFilterLayer implements IFirebaseModel{
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


@JsonSerializable()
class TermsFilter extends NewsFilter{
  TermsFilter(this.terms, {@required this.action});
  @JsonKey(ignore: true)
  @override
  String get name => this.terms;

  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "action")
  @override
  FilterAction action;
  @JsonKey(name: "terms")
  String terms;


  factory TermsFilter.fromJson(Map<String, dynamic> json) => _$TermsFilterFromJson(json);
  Map<String, dynamic> toJson() => _$TermsFilterToJson(this);
}

enum OperationType{
  And,
  Or
}

enum FilterMatchType{
  Contains,
  Matches,
  NotContains,
  NotMatches,
}


enum FilterAction{
  ALERT,
  NOTIFY,
  HIGHLIGHT,
  SILENCE,
  HIDE,
  IGNORE,
}

enum FilterScope{
  Title,
  Body
}

class NewsFilterResult{
  NewsFilterResult(this.matched, {this.action, this.highlights, this.score, this.maxScore, this.terms,});
  final bool matched;
  final FilterAction action;
  final NewsHighlights highlights;
  final String terms;
  final score;
  final maxScore;

  @override
  String toString() => "matched >> $matched action >> $action";
}