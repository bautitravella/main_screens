import 'package:flutter/material.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/comentarios_estado.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';

class SeleccionMateria extends StatefulWidget {
  @override
  _SeleccionMateriaState createState() => _SeleccionMateriaState();
}

void onLogoPressed(BuildContext context) {}
void onProfilePicture(BuildContext context) {}
void onButtonPressed(BuildContext context) {}

class _SeleccionMateriaState extends State<SeleccionMateria> {
  bool _isChecked = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  Map<String, bool> values = {

    'Matematica': false,
    'Lengua': false,
    'Historia': false,
    'Literatura': false,
    'Filosofia': false,
    'CS Sociales': false,
    'Quimica': false,
    'Biologia': false,
    'Ntix': false,
    'Estado y Sociedad': false,
    'History': false,




  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*3),
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
                          left: 4, right: 4, top: 25, bottom: 15),
                      child: ListView(
                        children: values.keys.map((String key) {
                          return Column(
                            children: <Widget>[
                              CheckboxListTile(
                                title: new Text(
                                  key,
                                  style: TextStyle(
                                      fontFamily: "Gibson",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 69, 79, 99)),
                                ),
                                value: values[key],
                                onChanged: (bool value) {
                                  setState(() {
                                    values[key] = value;
                                  });
                                },
                              ),
                              Container(
                                width: 180,
                                height: 2,
                                color: Colors.black12,
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Text(
                "Selecciona la \nmateria",
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
                "No es necesario seleccionar una materia, \npero ayuda a que te encuentren mas fácil. ",
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
      home: new SeleccionMateria(), debugShowCheckedModeBanner: false));
}
