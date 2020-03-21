import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inked/widget/token_filter_tester.dart';

class FilterTestingScreen extends StatefulWidget{
  static const routeName = "filter/testing";
  @override
  State<StatefulWidget> createState() => _FilterTestingScreenState();
}

class _FilterTestingScreenState extends State<FilterTestingScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("filter testing"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('select filter to test...'),
            TokenFilterTester(),
          ],
        ),
      ),
    );
  }

}