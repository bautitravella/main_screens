

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';

class StringTile extends StatelessWidget{

  String str;

  StringTile(this.str);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
      height: 68,
      width: SizeConfig.blockSizeHorizontal * 100,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 5,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).iconTheme.color,
            size: 20,
          ),
          SizedBox(width: 10),
          Container(
            width: SizeConfig.blockSizeHorizontal*71,
            height: double.maxFinite,
            margin: EdgeInsets.only(right: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: Text(
                  str,
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}