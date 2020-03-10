import 'package:flutter/material.dart';

///
/// README
/// this screen is for spam detection data collection.
/// game like design of document labeling
///

class SpamOrNotScreen extends StatefulWidget {
  static const routeName = "/misc/spam-or-not";
  @override
  State<StatefulWidget> createState() => _SpamOrNotScreenState();
}

class _SpamOrNotScreenState extends State<SpamOrNotScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("spam or not"),
      ),
    );
  }

}
