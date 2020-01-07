import 'package:flutter/material.dart';
import 'package:flutterui/subi_foto_perfil_widget/subi_foto_perfil_widget.dart';
import 'package:flutterui/values/values.dart';

class ElijeUnRolWidget extends StatelessWidget {

  void onLogoPressed(BuildContext context) {}
  void onButtonPressed(BuildContext context) {}
  void onRectangle648Pressed(BuildContext context) {}
  void onRectangle649Pressed(BuildContext context) {}

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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 28, top: 85),
                child: Text(
                  "Tu Cuenta",
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
                margin: EdgeInsets.only(top: 20, bottom: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 60,
                      top: 0,
                      right: 60,
                      child: Image.asset(
                        "assets/images/parentandchild.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      left: 92,
                      right: 91,
                      bottom: 0,
                      child: Text(
                        "Elije un rol",
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
                      width: 99,
                      height: 35,
                      margin: EdgeInsets.only(
                          left: 1, right: 180, top: 250, bottom: 12),
                      child: Opacity(
                        opacity: 1,
                        child: FlatButton(
                          onPressed: () => this.onRectangle648Pressed(context),
                          color: Color.fromARGB(200, 57, 57, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(17.5)),
                          ),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Padre",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: -0.36,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 99,
                      height: 35,
                      margin: EdgeInsets.only(
                          left: 180, right: 1, top: 250, bottom: 12),
                      child: Opacity(
                        opacity: 1,
                        child: FlatButton(
                          color: Color.fromARGB(200, 57, 57, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(17.5)),
                          ),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Alumno",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: -0.36,
                            ),
                          ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SubiFotoPerfilWidget()),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
              child: Text(
                "Esto determinara cuantos cursos \nestarán disponibles dentro de la app.\n",
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
    );
  }
}
