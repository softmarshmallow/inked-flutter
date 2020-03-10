import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:inked/screen/filter_settings_screen.dart';
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
          title: Text('dev - sound'),
          onTap:  () async {
            AudioPlayer audioPlayer = AudioPlayer();
            var res = await audioPlayer.play("https://freesound.org/data/previews/147/147597_2173181-lq.mp3");
            var eres = await audioPlayer.play("beep.mp3", isLocal: true);
          },
        ),

      ],
    ),
  );
}
