import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';

class ComentariosMateria extends StatefulWidget {
  @override
  _ComentariosMateriaState createState() => _ComentariosMateriaState();
}

void onLogoPressed(BuildContext context) {}
void onProfilePicture(BuildContext context) {}
void onButtonPressed(BuildContext context) {}

class _ComentariosMateriaState extends State<ComentariosMateria> {
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
                  alignment: Alignment.center,
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
                      height: 305,
                      margin: EdgeInsets.only(
                          left: 4, right: 4, top: 15, bottom: 90),
                      child: ListView(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: "ESTADO",
                                  contentPadding: EdgeInsets.only(left: 6),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 69, 79, 99),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    height: 2.1),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                autocorrect: true,
                              ),
                              Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 42),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 69, 79, 99),
                                      height: 2,
                                      width: 200,
                                      margin: EdgeInsets.only(top: 40),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
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
                            builder: (context) => ComentariosMateria()),
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
      home: new ComentariosMateria(), debugShowCheckedModeBanner: false));
}
