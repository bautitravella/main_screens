
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/values/values.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../size_config.dart';


class CursoAlumnoWidget extends StatefulWidget {
  User user;
  CursoAlumnoWidget(this.user);

  @override
  _CursoAlumnoWidgetState createState() => _CursoAlumnoWidgetState();
}
class _CursoAlumnoWidgetState extends State<CursoAlumnoWidget> {

  void onLogoPressed(BuildContext context) {}
  void onBtnBlueTwoPressed(BuildContext context) {}

  List<DropdownMenuItem> items = [];
  String selectedValue;
  @override
  void initState() {
    for(int i=0; i < 20; i++){
      items.add(new DropdownMenuItem(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  new Text(
                    'Colegio ' + i.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 53, 38, 65),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
        value: 'Colegio ' + i.toString(),
      )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 28, top: 85),
                  child: Text(
                    "Casi listos",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 57, 57, 57),
                      fontWeight: FontWeight.w400,
                      fontSize: 38,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 39, bottom: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 80,
                        right: 80,
                        bottom: 0,
                        child: Text(
                          "Selecciona\ncolegio y curso",
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
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/phonochico.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 40,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 80,
                              margin: EdgeInsets.only(left: 100, right: 110),
                              child: ClipRRect(
                                child: Image.asset("assets/images/group-1840.png"),
                              )
                            ),
                            Container(
                              width: 170,
                              height: 45,
                              margin: EdgeInsets.only(left: 110, right: 110, top: 20),
                              child: Opacity(
                                opacity: 0.37,
                                child: new DropdownButton(
                                  icon: Icon(Icons.menu),
                                      underline: Text(""),
                                      items: items,
                                      isExpanded: true,
                                      value: selectedValue,
                                      hint: new Text(
                                      'COLEGIO',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 53, 38, 65),
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19,
                                        ),
                                      ),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      }
                                      );
                                    },
                                ),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 180,
                              margin: EdgeInsets.only(left: 100, right: 100),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(77, 0, 0, 0),
                              ),
                            ),
                            Container(
                              width: 170,
                              height: 45,
                              margin: EdgeInsets.only(left: 110, right: 110, top: 40),
                              child: Opacity(
                                opacity: 0.37,
                                child: new DropdownButton(
                                  icon: Icon(Icons.menu),
                                  underline: Text(""),
                                  items: items,
                                  isExpanded: true,
                                  value: selectedValue,
                                  hint: new Text(
                                    'CURSO',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 53, 38, 65),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    }
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 180,
                              margin: EdgeInsets.only(left: 100, right: 100),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(77, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: SizeConfig.blockSizeVertical*7),
                child: Text(
                  "Los datos ingresados se podrán\ncambiar mas tarde \ndentro de la app\n",
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
                      onPressed: () => []
                  ),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  siguienteBtn(BuildContext context){
    //chequear si el usuario eligio un colegio y un curso

      //agregar los datos al usuario

      //pasar a la siguiente pantalla
  }
}

