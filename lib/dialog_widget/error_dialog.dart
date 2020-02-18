import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';


class ErrorDialog extends StatelessWidget {

  String title,error;
  ErrorDialog(
      {@required this.title, this.error,});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: Container(
          width: SizeConfig.blockSizeHorizontal*100,
          padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
          child: Stack(
            children: <Widget>[
              Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Image.asset("assets/images/alert-dialog.png")
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Color.fromARGB(255, 136, 136, 136),
                        fontFamily: "Sf-r",
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: SizeConfig.blockSizeHorizontal*45,
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 104, 104),
                          fontFamily: "Sf-r",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}