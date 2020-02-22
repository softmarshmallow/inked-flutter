import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
          title: Text('Watch dogs'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Train data'),
          onTap: () {
            // Update the state of the app.
            // ...
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
