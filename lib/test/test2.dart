import 'package:flutter/material.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/test/textfield/textfield_widget.dart';
import 'package:flutterui/values/colors.dart';

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8, left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Iniciar sesión",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  "Correo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BeautyTextfield(
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color
                  textColor: Colors.black, //Text Color
                  backgroundColor: Color.fromARGB(255, 222, 222, 222), //Not Focused Color
                  fontFamily: 'Sf', //Text Fontfamily
                  fontWeight: FontWeight.w500,
                  autofocus: true,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,//REQUIRED
                  obscureText: false, //REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (text) {
                    print(text);
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(height: 40),
                Text(
                  "Contraseña",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BeautyTextfield(
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color
                  textColor: Colors.black, //Text Color
                  backgroundColor: Color.fromARGB(255, 222, 222, 222), //Not Focused Color
                  textBaseline: TextBaseline.alphabetic,
                  fontFamily: 'Sf', //Text Fontfamily
                  fontWeight: FontWeight.w500,
                  passwordIcon: true,
                  obscureText: true,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.text, //REQUIRED//REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (text) {
                    print(text);
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(height: 40),
                Text(
                  "¿Has olvidado la contraseña?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontSize: 15,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Conectate con",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => {},
                    color: AppColors.accentElement,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(112, 112, 112, 112),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    textColor: Color.fromARGB(255, 117, 117, 117),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints.expand(),
                        ),
                        Text(
                          "Continuar con Google",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 117, 117, 117),
                            fontFamily: "Sf",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            "assets/images/login-google.png", scale: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => {},
                    color: Color.fromARGB(255, 74, 74, 74),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(112, 112, 112, 112),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    textColor: Color.fromARGB(255, 117, 117, 117),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints.expand(),
                        ),
                        Text(
                          "Continuar con Apple",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Sf",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            "assets/images/login-apple.png", scale: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 15),
                  child: FlatButton(
                    onPressed: () => {},
                    color: Color.fromARGB(255, 222, 222, 222),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        "Iniciar Sesión",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 174, 174, 174),
                          fontFamily: "Sf",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
