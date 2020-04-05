
import 'package:flutter/material.dart';

class MainAppBar extends AppBar{
  final Function onSearchPressed;
  MainAppBar({this.onSearchPressed}): super(
    title: Text("inked"),
    actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: onSearchPressed,)
    ],
    bottom: new PreferredSize(
      preferredSize: new Size(500.0, 40.0),
      child: new Container(
        width: 500.0,
        child: new TabBar(
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4.0),
              insets: EdgeInsets.symmetric(horizontal:0)
          ),
          tabs: [
            new Tab(text: 'all'),
            new Tab(text: 'no spam'),
            new Tab(text: 'only filtered'),
          ],
        ),
      ),
    ),
  );
}
