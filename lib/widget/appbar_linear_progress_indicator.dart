import 'package:flutter/material.dart';

const double _kMyLinearProgressIndicatorHeight = 6.0;

class AppbarLinearProgressIndicator extends LinearProgressIndicator
    implements PreferredSizeWidget {
  AppbarLinearProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
  }) : super(
    key: key,
    value: value,
    backgroundColor: backgroundColor,
    valueColor: valueColor,
  ) {
    preferredSize = Size(double.infinity, _kMyLinearProgressIndicatorHeight);
  }

  @override
  Size preferredSize;
}