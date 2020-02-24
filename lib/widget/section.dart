import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget child;
  final String title;
  EdgeInsets _padding = EdgeInsets.only(top: 12);

  Section(this.title, {@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: _padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            child
          ],
        ));
  }
}
