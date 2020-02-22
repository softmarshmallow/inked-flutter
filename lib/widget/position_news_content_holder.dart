import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/widget/content_detail.dart';

class PositionedNewsContentHolder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PositionedNewsContentHolder();
}

class _PositionedNewsContentHolder extends State<PositionedNewsContentHolder> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border.symmetric(
              vertical: BorderSide(width: 4, color: Colors.blueAccent)),
        ),
        child: Stack(
          children: <Widget>[
            ContentDetailView(),
            _buildKnob(),
          ],
        ),
      ),
    );
  }

  Widget _buildKnob() {
    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: 50,
        height: 16,
        color: Colors.black,
      ),
    );
  }

  void onVerticalDragUpdate(DragUpdateDetails update) {}
}
