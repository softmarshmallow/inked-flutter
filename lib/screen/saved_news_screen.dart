import 'package:flutter/material.dart';

class SavedNewsScreen extends StatefulWidget {
  static const routeName = "/news/saved";

  @override
  State<StatefulWidget> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("saved"),
      ),
    );
  }
}
