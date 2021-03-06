import 'package:flutter/material.dart';
import 'package:inked/screen/development/development_landing_screen.dart';
import 'package:inked/screen/filters/filter_terms_screen.dart';
import 'package:inked/screen/filters/filter_testing_screen.dart';
import 'package:inked/screen/providers_selectin_screen.dart';
import 'package:inked/screen/saved_news_screen.dart';
import 'package:inked/screen/search_screen.dart';
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
            Navigator.of(context).pushNamed(TermsFilterScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.filter_list),
          title: Text('provider settings'),
          onTap: () {
            Navigator.of(context).pushNamed(ProvidersSelectionScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('search'),
          onTap: () {
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.inbox),
          title: Text('saved'),
          onTap: () {
            Navigator.of(context).pushNamed(FavoriteNewsScreen.routeName);
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
