
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';


class FirstscreenWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: -58,
              top: 22,
              right: -59,
              child: Image.asset(
                "assets/images/il-fullxfull1474175299-kn3e.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              top: 22,
              right: 0,
              child: Opacity(
                opacity: 0.63,
                child: Container(
                  height: 582,
                  decoration: BoxDecoration(
                    color: AppColors.ternaryBackground,
                  ),
                  child: Container(),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryElement,
                    ),
                    child: Container(),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 290,
                      height: 81,
                      margin: EdgeInsets.only(top: 31, right: 27),
                      child: Image.asset(
                        "assets/images/artboard-7.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 142,
                    decoration: BoxDecoration(
                      color: AppColors.ternaryBackground,
                      boxShadow: [
                        Shadows.secondaryShadow,
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Text(
                            "LOG IN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              letterSpacing: 0.08,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 71,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  boxShadow: [
                    Shadows.secondaryShadow,
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        letterSpacing: 0.08,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}