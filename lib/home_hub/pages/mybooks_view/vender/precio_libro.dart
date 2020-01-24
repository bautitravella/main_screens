import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';

class PrecioLibro extends StatefulWidget {
  @override
  _PrecioLibroState createState() => _PrecioLibroState();
}

void onLogoPressed(BuildContext context) {}
void onProfilePicture(BuildContext context) {}
void onButtonPressed(BuildContext context) {}

class _PrecioLibroState extends State<PrecioLibro> {

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 30.0,
                        color: AppColors.accentText,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: 24),
                child: Text(
                  "Vender",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Gibson",
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w600,
                    fontSize: 38,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/phonochico.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      width: 215,
                      height: 100,
                      margin: EdgeInsets.only(
                          left: 4, right: 4, top: 30),
                      child: Row(
                        children: <Widget>[
                            Icon(Icons.attach_money,
                            size: 60.0,
                            color: Color.fromARGB(255, 112, 112, 112),
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 80,
                                width: SizeConfig.blockSizeHorizontal*35,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: "PRECIO",
                                    hintStyle: TextStyle(color: Color.fromARGB(20, 0, 0, 0),),
                                    contentPadding: EdgeInsets.only(top: 20),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 112, 112, 112),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30,),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                child: Container(
                                  color: Color.fromARGB(105, 112, 112, 112),
                                  height: 2,
                                  width: SizeConfig.blockSizeHorizontal*35,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ),
                    Container(
                      width: 215,
                      margin: EdgeInsets.only(
                          left: 6,
                          right: 4,
                          top: SizeConfig.blockSizeVertical * 35),
                      child: CheckboxListTile(
                        title: const Text(
                          'Dale "tick" si es que el libro es nuevo',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color.fromARGB(180, 69, 79, 99),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        value: _isSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSelected = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Text(
                "Comenta \nsobre el estado",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 53, 38, 65),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  letterSpacing: -0.41786,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 35),
              child: Text(
                "Escribe una breve descripción \ndel estado del libro que vallas a vender.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 118, 118),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  letterSpacing: -0.1,
                  height: 1.4,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 124,
                height: 44,
                margin: EdgeInsets.only(right: 3, bottom: 30),
                child: FlatButton(
                    color: AppColors.secondaryElement,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons-back-light-2.png",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Siguiente",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrecioLibro()),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
      home: new PrecioLibro(), debugShowCheckedModeBanner: false));
}
