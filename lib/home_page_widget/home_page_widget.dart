
import 'package:flutter/material.dart';
import 'package:flutterui/values/values.dart';



class HomePageWidget extends StatelessWidget {
  
  void onGroup1862Pressed(BuildContext context) {
  
  }
  
  void onGroup1864Pressed(BuildContext context) {
  
  }
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 228, 228, 228),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 269,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 1,
                    right: 0,
                    child: Image.asset(
                      "assets/images/photo-85889-landscape-850x566.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 269,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(115, 57, 57, 57),
                        border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 112, 112, 112),
                        ),
                      ),
                      child: Container(),
                    ),
                  ),
                  Positioned(
                    left: 54,
                    top: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 143,
                          margin: EdgeInsets.only(left: 100),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 38,
                                    margin: EdgeInsets.only(top: 94, right: 23, left: 23),
                                    child: Image.asset(
                                      "assets/images/buymy-whitelogo.png",
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 138,
                                  height: 143,
                                  child: Image.asset(
                                    "assets/images/round-underpic.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 14,right: 53),
                          child: Text(
                            "Todos los libros en\nun solo lugar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                              height: 0.92308,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 21, top: 14, right: 71),
                          child: Opacity(
                            opacity: 0.71941,
                            child: Text(
                              "!Encontralos ya!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 43,
                    right: 18,
                    child: Container(
                      width: 50,
                      height: 51,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(41, 0, 0, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/1005-viernes-fluvial-mari-343-3.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}