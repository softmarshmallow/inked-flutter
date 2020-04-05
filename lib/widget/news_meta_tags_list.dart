
import 'package:flutter/material.dart';

class NewsMetaTagsList extends StatelessWidget {
  final List<String> tags;
  final TextStyle textStyle;

  NewsMetaTagsList(this.tags, this.textStyle);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) {
          var item = tags[index];
          return Padding(
            padding: EdgeInsets.only(right: 2),
            child: Chip(
                backgroundColor: Colors.grey[200],
                label: Text(
                  item,
                  style: textStyle,
                )),
          );
        });
  }
}
