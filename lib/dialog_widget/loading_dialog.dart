import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';


class LoadingDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: SizeConfig.blockSizeHorizontal*100,
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedIcon(
              icon: AnimatedIcons.pause_play,
            )

          ],
        ),
      ),
    );
  }
}