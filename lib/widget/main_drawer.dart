import 'package:flutter/material.dart';
import 'package:inked/screen/development/development_landing_screen.dart';
import 'package:inked/screen/filter_settings_screen.dart';
import 'package:inked/screen/filter_testing_screen.dart';
import 'package:inked/screen/saved_news_screen.dart';
import 'package:inked/screen/spam_or_not_screen.dart';

Widget buildMainDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('inked v0.0.1', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
        ListTile(
          leading: Icon(Icons.filter_list),
          title: Text('filter'),
          onTap: () {
            Navigator.of(context).pushNamed(FilterSettingsScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.filter_list),
          title: Text('filter testing'),
          onTap: () {
            Navigator.of(context).pushNamed(FilterTestingScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.inbox),
          title: Text('saved'),
          onTap: () {
            Navigator.of(context).pushNamed(SavedNewsScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.done_all),
          title: Text('spam or not'),
          onTap: () {
            Navigator.of(context).pushNamed(SpamOrNotScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.developer_mode),
          title: Text('development'),
          onTap: () {
            Navigator.of(context).pushNamed(DevelopmentLandingScreen.routeName);
          },
        ),
      ],
    ),
  );
}
