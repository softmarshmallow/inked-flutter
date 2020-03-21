import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/blocs/token_filter_tester/bloc.dart';
import 'package:inked/data/local/mock/mock_filter_db.dart';
import 'package:inked/widget/token_filter_tester.dart';

class FilterTestingScreen extends StatefulWidget {
  static const routeName = "filter/testing";

  @override
  State<StatefulWidget> createState() => _FilterTestingScreenState();
}

class _FilterTestingScreenState extends State<FilterTestingScreen> {
  FilterTesterBloc _bloc;

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("filter testing"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildFilterSelectionSection(context),
                BlocProvider(
                  create: (context) {
                    _bloc = FilterTesterBloc();
                    return _bloc;
                  },
                  child: TokenFilterTester(),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildFilterSelectionSection(BuildContext context){
    return Column(
      children: <Widget>[
        Text('select filter to test...'),
        RaisedButton(onPressed: (){
          _bloc.add(TestFilterUpdateEvent(MockFilterDatabase.filter));
        }, child:Text("use mock filter"),)
      ],
    );
  }
}
