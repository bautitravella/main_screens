import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';

class CustomDialog extends StatelessWidget {
  final primaryColor = const Color(0xFF75A2EA);
  final grayColor = const Color(0xFF939393);

  final String title,
      description,
      primaryButtonText,
      primaryButtonRoute,
      secondaryButtonText,
      secondaryButtonRoute;

  CustomDialog(
      {@required this.title,
        @required this.description,
        @required this.primaryButtonText,
        @required this.primaryButtonRoute,
        this.secondaryButtonText,
        this.secondaryButtonRoute});

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal*100,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80), bottomRight: Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 57, 57, 57),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    description,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 57, 57, 57),
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
            )
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