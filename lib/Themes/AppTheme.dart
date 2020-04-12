import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: Color.fromARGB(255, 254, 189, 16),
   /* appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),*/
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontFamily: "Sf",
        fontWeight: FontWeight.w700,
      ),//Los headers del las bars
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: "Sf",
        fontWeight: FontWeight.w600,
      ),// Los headers de los textfields
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: "Sf",
        fontWeight: FontWeight.w500,
      ), //Texto de los textfields
      headline4: TextStyle(
        color: Color.fromARGB(255, 100, 100, 100),
        fontSize: 15,
        fontFamily: "Sf",
        fontWeight: FontWeight.w600,
      ),//Sub text de los Texfields
      headline5: TextStyle(
        color: Colors.white,
        fontFamily: "Sf",
        fontWeight: FontWeight.w700,
        fontSize: 15,
      )//texto de botones

    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 29, 29, 29),
    accentColor: Color.fromARGB(255, 254, 189, 16),
    /* appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),*/
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontFamily: "Sf",
        fontWeight: FontWeight.w700,
      ),//Los headers del las bars
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: "Sf",
        fontWeight: FontWeight.w600,
      ),// Los headers de los textfields
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: "Sf",
        fontWeight: FontWeight.w500,
      ), //Texto de los textfields
      headline4: TextStyle(
        color: Color.fromARGB(255, 180, 180, 180),
        fontSize: 15,
        fontFamily: "Sf",
        fontWeight: FontWeight.w600,
      ),//Sub text de los Texfields
      headline5: TextStyle(
          color: Colors.black,
          fontFamily: "Sf",
          fontWeight: FontWeight.w700,
          fontSize: 15,
        )//texto de botones

    ),
  );
}
