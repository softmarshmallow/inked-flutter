import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContentDetailView();
}

class _ContentDetailView extends State<ContentDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitleSection(),
          _buildContentSection(),
          _buildFooterSection()
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Text(
      "Title place holder",
      style: Theme.of(context).textTheme.headline3,
    );
  }

  Widget _buildContentSection() {
    return SizedBox.shrink();
  }

  Widget _buildFooterSection() {
    return SizedBox.shrink();
  }
}
