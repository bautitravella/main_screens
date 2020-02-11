
import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/log_in/curso_alumno_widget.dart';
import 'package:flutterui/values/values.dart';


class DatosWidget extends StatelessWidget {


  void onLogoPressed(BuildContext context) {}
  void onBtnBlueTwoPressed(BuildContext context) {}

  User user;
  TextEditingController usernameController = new TextEditingController(),nombreController = new TextEditingController(), apellidoController = new TextEditingController();
  DatosWidget(this.user);

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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: 85),
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
                margin: EdgeInsets.only(top: 39, bottom: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 92,
                      right: 91,
                      bottom: 0,
                      child: Text(
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.only(left: 100, right: 110, top: 81),
                        child: Opacity(
                          opacity: 0.57,
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "USERNAME",
                              contentPadding: EdgeInsets.all(0),
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
                    ),
                Align(
                  alignment: Alignment.topCenter,
                  child:Container(
                    height: 2,
                    margin: EdgeInsets.only(left: 100, right: 100, top: 120),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                    child: Container(),
                  ),
                ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.only(left: 100, right: 110, top: 161),
                        child: Opacity(
                          opacity: 0.57,
                          child: TextField(
                            controller: nombreController,
                            decoration: InputDecoration(
                              hintText: "NOMBRE",
                              contentPadding: EdgeInsets.all(0),
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
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                    child:Container(
                      height: 2,
                      margin: EdgeInsets.only(left: 100, right: 100, top: 200),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(77, 0, 0, 0),
                      ),
                      child: Container(),
                    ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.only(left: 100, right: 110, top: 241),
                        child: Opacity(
                          opacity: 0.57,
                          child: TextField(
                            controller: apellidoController,
                            decoration: InputDecoration(
                              hintText: "APELLIDO",
                              contentPadding: EdgeInsets.all(0),
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
                    ),
                Align(
                  alignment: Alignment.topCenter,
                  child:Container(
                    height: 2,
                    margin: EdgeInsets.only(left: 100, right: 100, top: 280),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(77, 0, 0, 0),
                    ),
                    child: Container(),
                  ),
                ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 50),
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
    );
  }

  siguienteBtn(BuildContext context) {
    if(usernameController.text.isNotEmpty || nombreController.text.isNotEmpty || apellidoController.text.isNotEmpty){
      //cargamos la informacion al usuario

      //pasamos a la siguiente pantalla

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CursoAlumnoWidget(user)),
      );
    }

    //muestro mensaje de error


  }
}