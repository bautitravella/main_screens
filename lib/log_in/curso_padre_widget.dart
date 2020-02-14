
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/terminos_ycondiciones_widget.dart';
import 'package:flutterui/values/values.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../size_config.dart';


class CursoPadreWidget extends StatefulWidget {
  User user;
  CursoPadreWidget(this.user);

  @override
  _CursoPadreWidgetState createState() => _CursoPadreWidgetState();
}
class _CursoPadreWidgetState extends State<CursoPadreWidget> {
  User user;
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
                  margin: EdgeInsets.only(left: 28, top: SizeConfig.blockSizeVertical*12),
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
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*6, bottom: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/phonochico4.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        child: Text(
                          "1",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.blockSizeVertical*2,
                        bottom: SizeConfig.blockSizeVertical*26,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                margin: EdgeInsets.only(left: 110, right: 110, top: SizeConfig.blockSizeVertical*3),
                                child: Opacity(
                                  opacity: 0.57,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "NOMBRE",
                                      contentPadding: EdgeInsets.only(top: 30),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 53, 38, 65),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                    ),
                                    maxLines: 1,
                                    autocorrect: false,
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
                                margin: EdgeInsets.only(left: 110, right: 110, top: SizeConfig.blockSizeVertical*4),
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
                                margin: EdgeInsets.only(left: 110, right: 110, top: SizeConfig.blockSizeVertical*4),
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
                      ),
                      Positioned(
                        left: 60,
                        right: 60,
                        bottom: SizeConfig.blockSizeVertical*2,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Completa los \ndatos del familiar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 53, 38, 65),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                                letterSpacing: -0.41786,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2),
                              child: Text(
                                "Debes completar los datos del familiar que deseas ingresar. No se preocupe si tiene mas de uno. Puede agregar otro con el botón de 'agregar otro'",
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 124,
                      height: 44,
                      margin: EdgeInsets.only(left: 3, bottom: 10),
                      child: FlatButton(
                          color: AppColors.secondaryElement,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Agregar otro",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () => siguienteBtn(context)
                      ),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                    ),
                    Container(
                      width: 124,
                      height: 44,
                      margin: EdgeInsets.only(right: 3, bottom: 10),
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
                                "Finalizar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () => siguienteBtn(context)
                      ),
//                    {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => CursoAlumnoWidget(user)),
//                      );
//                    }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  siguienteBtn(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TerminosYCondicionesWidget(user)));
    //Mostrar un mensaje de error
  }

}
 // siguienteBtn(BuildContext context){
    //chequear si el usuario eligio un colegio y un curso

    //agregar los datos al usuario

    //pasar a la siguiente pantalla
 // }
//}

