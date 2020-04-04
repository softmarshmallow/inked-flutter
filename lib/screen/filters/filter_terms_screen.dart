
import 'package:flutter/material.dart';
import 'package:inked/data/model/filter.dart';

class TermsFilterScreen extends StatefulWidget{
  static const String routeName = "/settings/filter/terms";
  @override
  State<StatefulWidget> createState() => _TermsFilterScreenState();
}


class _TermsFilterScreenState extends State<TermsFilterScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("terms filter"),),
      body: Column(children: <Widget>[

      ],),
    );
  }

}

class TermsFilterListItem extends StatelessWidget{
  TermsFilter termsFilter;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TextField(),
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: (){},
        )
      ],
    );
  }


}