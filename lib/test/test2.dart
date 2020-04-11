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
      body: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*8, left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
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
                fontSize: 20,
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
              margin: EdgeInsets.only(top: 10),
              cornerRadius: BorderRadius.all(Radius.circular(15)),
              duration: Duration(milliseconds: 300),
              inputType: TextInputType.text, //REQUIRED
              obscureText: false, //REQUIRED
              eyeColor: Colors.transparent,
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
            SizedBox(height: 20),
            Text(
              "Contraseña",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
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
              margin: EdgeInsets.only(top: 10),
              cornerRadius: BorderRadius.all(Radius.circular(15)),
              duration: Duration(milliseconds: 300),
              inputType: TextInputType.text, //REQUIRED
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
          ],
        ),
      ),

    );
  }
}
