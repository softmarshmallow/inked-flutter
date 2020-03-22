import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';

class SingleTokenLayerListTile extends StatelessWidget{
  final SingleTokenFilterLayer layer;
  final List<Widget> trails;
  SingleTokenLayerListTile(this.layer, {this.trails});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.text_fields),
        title: Text("\"${layer.token}\" in ${layer.scope}"),
        subtitle: Text("${layer.scope} ${layer.match}"),
        trailing: trails != null? trails : SizedBox.shrink()
    );
  }

}