
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/curso_alumno_widget.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';

import 'curso_padre_widget.dart';


class DatosWidget extends StatefulWidget {
  User user;
  DatosWidget(this.user);


  DatosWidgetState createState() => DatosWidgetState(user);
}

class DatosWidgetState extends State<DatosWidget>{

  DatosWidgetState(this.user);

  void onLogoPressed(BuildContext context) {}
  void onBtnBlueTwoPressed(BuildContext context) {}

  User user;
  TextEditingController nombreController = new TextEditingController(), apellidoController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  margin: EdgeInsets.only(left: 28,top: SizeConfig.blockSizeVertical*12),
                  child: Text(
                    "Falta poco",
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
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*6, bottom: 12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/phonochico2.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.blockSizeVertical*8,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 60,
                              margin: EdgeInsets.only(left: 100, right: 110),
                              child: Opacity(
                                opacity: 0.57,
                                child: TextField(
                                  controller: nombreController,
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
                              width: 150,
                              height: 60,
                              margin: EdgeInsets.only(left: 100, right: 110, top: SizeConfig.blockSizeVertical*3),
                              child: Opacity(
                                opacity: 0.57,
                                child: TextField(
                                  controller: apellidoController,
                                  decoration: InputDecoration(
                                    hintText: "APELLIDO",
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
                          ],
                        ),
                      ),
                      Positioned(
                        left: 60,
                        right: 60,
                        bottom: SizeConfig.blockSizeVertical*3,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Ingresa tus\ndatos",
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
                                "Los datos ingresados se podrán\ncambiar mas tarde dentro de la app\n",
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
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    if(nombreController.text.isNotEmpty || apellidoController.text.isNotEmpty){
      //cargamos la informacion al usuario

      user.nombre = nombreController.text;
      user.apellido = apellidoController.text;

      //pasamos a la siguiente pantalla
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => user is Padre? CursoPadreWidget(user):CursoAlumnoWidget(user))
      );

    }else{
      //Mostrar mensaje de error
    }
  }
}
