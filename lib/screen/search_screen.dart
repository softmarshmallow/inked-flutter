import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  static const routeName = "/search";
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search"),
        actions: <Widget>[
          SizedBox(
            width: 500,
            height: 150,
            child: TextField(),
          )
        ],
      ),
    );
  }
}