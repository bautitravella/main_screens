import 'package:flutter/material.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/log_in/sign_up.dart';
import 'package:flutterui/log_in/log_in.dart';


class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/il-fullxfull1474175299-kn3e.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.73,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.ternaryBackground,
                  ),
                  child: Container(),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 50),
                    child: Text(
                      "Bienvenido a Buymy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 80),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 15),
                    color: AppColors.secondaryBackground,
                    child: Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Sf",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                      onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                      }
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    color: Color.fromARGB(255, 222, 222, 222),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontSize: 18,
                        fontFamily: "Sf",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      }
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
