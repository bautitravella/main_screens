import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';

class AlertDialog extends StatelessWidget {
  final primaryColor = const Color(0xFF75A2EA);
  final grayColor = const Color(0xFF939393);

  String title,
      description,
      primaryButtonText,
      primaryButtonRoute,
      secondaryButtonText,
      secondaryButtonRoute;
  Function primaryFunction,secondaryFunction;


  AlertDialog(
      {@required this.title,
        @required this.description,
        @required this.primaryButtonText,
        @required this.primaryButtonRoute,
        this.secondaryButtonText,
        this.secondaryButtonRoute});

  AlertDialog.customFunctions(
      {@required this.title, @required this.description,
        @required this.primaryButtonText, @required this.secondaryButtonText,this.primaryFunction,this.secondaryFunction
      });


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: SizeConfig.blockSizeHorizontal*100,
        padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Sf-r",
                fontSize: 27,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 57, 57, 57),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              description,
              maxLines: 4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Sf-t",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(205, 80, 80, 80),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: 350,
              height: 44,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: RaisedButton(
                color: Color.fromARGB(255, 57, 57, 57),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    primaryButtonText,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(primaryButtonRoute);
                },
              ),
            ),
            SizedBox(height: 10.0),
            showSecondaryButton(context),
          ],
        ),
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if (secondaryButtonRoute != null && secondaryButtonText != null ){
      return Container(
        width: 350,
        height: 44,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 35),
        child: FlatButton(
          color: AppColors.secondaryBackground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),

          child: Text(
            secondaryButtonText,
            maxLines: 1,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
          },
        ),
      );
    } else {
      return SizedBox(height: 10.0);
    }
  }
}