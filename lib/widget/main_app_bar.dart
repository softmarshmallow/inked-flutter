
import 'package:flutter/material.dart';

enum MainTabsType{
  ALL,
  EXCLUDE_SPAM,
  ONLY_HITS
}

const Map<int, MainTabsType> TAB_MAP = {
  0: MainTabsType.ALL,
  1: MainTabsType.EXCLUDE_SPAM,
  2: MainTabsType.ONLY_HITS,
};


class MainAppBar extends AppBar{
  final Function onSearchPressed;
  final Function(MainTabsType tab) onTabTap;
  MainAppBar({this.onSearchPressed, this.onTabTap, }): super(
    title: Text("inked"),
    actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: onSearchPressed,)
    ],
    bottom: new PreferredSize(
      preferredSize: new Size(500.0, 40.0),
      child: new Container(
        width: 500.0,
        child: new TabBar(
          onTap: (i){
            onTabTap?.call(TAB_MAP[i]);
          },
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
