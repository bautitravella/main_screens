import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';


class LoadingDialog extends StatelessWidget {
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
                  child: Image.asset("assets/images/loading-dialog.png")
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Loading...",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1.color,
                        fontFamily: "Sf-r",
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: SizeConfig.blockSizeHorizontal*45,
                      child: Text(
                        "Se están cargando los datos.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 191, 191, 191),
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