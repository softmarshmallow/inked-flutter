import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/blocs/token_filter_tester/bloc.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/utils/token_filter_processor.dart';
import 'package:inked/widget/content_detail.dart';

class TokenFilterTester extends StatefulWidget {
  TokenFilterTester({Key key}) : super(key: key);

  @override
  _TokenFilterTesterState createState() => _TokenFilterTesterState();
}

class _TokenFilterTesterState extends State<TokenFilterTester> {
  var api = NewsApi(RemoteApiManager().getDio());
  FilterTesterBloc bloc;
  TokenFilterProcessor processor;

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<FilterTesterBloc>(context);
    return BlocBuilder<FilterTesterBloc, TokenFilterTesterViewState>(
      builder: (BuildContext context, TokenFilterTesterViewState state) {
        if (state is! InitialState && state.news != null && state.filter != null) {
          // update processor if not initial state. it is null to update processor when initial state
          processor = TokenFilterProcessor(state.news, state.filter);
          print('updated processor for tokenfilter testing');
        }

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("testing filter. filter is ${state.filter?.name}"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNewsDisplaySection(context, state),
                  _buildResultSection(context, state)
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _buildNewsDisplaySection(BuildContext context, TokenFilterTesterViewState state){
    return SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("load other news"),
              onPressed: () async {
                var fetched = await api.getSpamNews();
                setState(() {
                  bloc.add(TestNewsUpdateEvent(fetched));
                });
              },
            ),
            ContentDetailView(
              state.news,
              readOnly: true,
            ),
          ],
        ));
  }

  _buildResultSection(BuildContext context, TokenFilterTesterViewState state){
    if (processor != null) {
      var result = processor.process();
      return Text(result.toString());
    }  else{
      return Text('no news or filter is provided');
    }
  }
}
