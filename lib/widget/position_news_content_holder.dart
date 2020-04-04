import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/blocs/livenewslist/bloc.dart';
import 'package:inked/widget/content_detail.dart';

class PositionedNewsContentHolder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PositionedNewsContentHolder();
}

class _PositionedNewsContentHolder extends State<PositionedNewsContentHolder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListBloc, NewsListState>(
          builder: (context, state) {
            var content;
            if (state is NoFocusState) {
              content = Text("no selected content");
            }else{
              var news = state.news;
              content = ContentDetailView(news);
            }
            return Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: _desiredHeight(),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: content,
                    ),
                    _buildKnob(),
                  ],
                ),
              ),
            );
          });
  }

  static const double minHeight = 80.0;
  double _desiredHeight() {
    if (_globalDragPositionY == null) {
      return 400;
    } else {
      double height = MediaQuery.of(context).size.height;
      double desired = height - _globalDragPositionY;
      return max<double>(minHeight, desired);
    }
  }

  Widget _buildKnob() {
    return GestureDetector(
        onVerticalDragUpdate: onVerticalDragUpdate,
        child: Align(
          alignment: Alignment(0.0, -1),
          child: Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
                color: Colors.black),
          ),
        ));
  }

  double _globalDragPositionY;

  void onVerticalDragUpdate(DragUpdateDetails update) {
    setState(() {
      _globalDragPositionY = update.globalPosition.dy;
    });
  }
}
