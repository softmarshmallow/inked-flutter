import 'package:inked/remote_ui/ui/index.dart';
import 'package:json_annotation/json_annotation.dart';

import '../ui/index.dart' as rui;
part 'search.layout.g.dart';

@JsonSerializable()
class SearchLayoutBase {
  SearchLayoutBase();
  rui.Text title;
  rui.View content;
  rui.Avatar avatar;
  rui.View meta;

  factory SearchLayoutBase.fromJson(Map<String, dynamic> json) =>
      _$SearchLayoutBaseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLayoutBaseToJson(this);
}

