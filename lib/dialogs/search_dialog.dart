import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SearchDialog();
}

class _SearchDialog extends State<SearchDialog>{
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Inked Search engine",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.overline,
            ),
            TextField(
              style: Theme.of(context).textTheme.headline3,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a search term'
              ),
            ),
            Spacer(),
            _buildActionSection()
          ],
        ),
      )
    );
  }

  Widget _buildActionSection(){

    onGoPressed(){

    }

    onNewPagePressed(){

    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(child: Text("new page"), onPressed: onNewPagePressed,),
        FlatButton(child: Text("go"), onPressed: onGoPressed,),
      ],
    );
  }

}