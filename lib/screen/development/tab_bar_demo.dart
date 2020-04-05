import 'package:flutter/material.dart';
import 'package:inked/widget/main_app_bar.dart';

class TabBarDemoScreen extends StatefulWidget {
  static const routeName = "/development/tabbar-demo";

  @override
  State<StatefulWidget> createState() => _TabBarDemoScreenState();
}

class _TabBarDemoScreenState extends State<TabBarDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MainAppBar(),
      ),
    );
  }
}

