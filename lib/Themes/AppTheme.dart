import 'package:flutter/material.dart';
import 'package:flutterui/values/colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final _darkWall = Color.fromARGB(255, 10, 10, 10) ;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: AppColors.secondaryBackground,
    accentColor: Color.fromARGB(255, 254, 189, 16),
    hintColor: Color.fromARGB(255, 222, 222, 222),// fondo textfields sin apretar
    focusColor: Colors.white,// fondo textfields apretados
    hoverColor: Color.fromRGBO(0, 0, 0, 0.15),
    dialogBackgroundColor: Colors.white,
    dividerColor: Color.fromARGB(255, 255, 213, 104),

   /* appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),*/
    cardTheme: CardTheme(
      color: Color.fromARGB(255, 240, 240, 240),
    ),
    cardColor: Color.fromARGB(50, 249, 196, 55),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.red,
      size: 12
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
      ),//texto de botones
      headline6: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontFamily: "Sf",
      fontWeight: FontWeight.w700,
    ),//Titulos de configuracion
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: "Sf",
        fontWeight: FontWeight.w600,
      ), //Subtitulos de configuracion
      subtitle2: TextStyle(
        color: Colors.black87,
        fontSize: 15,
        fontFamily: "Sf",
        fontWeight: FontWeight.w400,
      ), //SubSubtitulos de configuracion
    ),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
          fontFamily: "Sf",
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 30,
        ),
      headline2: TextStyle(
        color: Color.fromARGB(200, 0, 0, 0),
        fontSize: 15,
        fontFamily: "Sf-r",
        fontWeight: FontWeight.w700,
      ), //Tile Book Name
      headline3: TextStyle(
        color: Color.fromARGB(200, 0, 0, 0),
        fontSize: 11,
        fontFamily: "Sf",
        fontWeight: FontWeight.w500,
      ),//Tile Author Name
      headline4:  TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: "Sf-r",
        color: Color.fromARGB(
            190, 0, 0, 0),
      ),//Tile User Name
      headline5: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        fontFamily: "Sf-r",
        color: Color.fromARGB(100, 0, 0, 0),
      ),//Tile Estado
      subtitle1: TextStyle(
        fontFamily: "Sf-r",
        color: Color.fromARGB(255, 79, 79, 79),
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),//Texto de los tiles
      ),
    accentTextTheme: TextTheme(
    headline1: TextStyle(
  fontFamily: "Sf",
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: 30,
  ), // Headline PageView
    headline2: TextStyle(
        fontFamily: "Sf",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color:
        Color.fromARGB(255, 57, 57, 57),
      ),//User Name NotificationView
    headline3: TextStyle(
        fontFamily: "Sf",
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(
            255, 57, 57, 57),
      ),//Last Message NotificationView
    headline4: TextStyle(
          fontFamily: "Sf-r",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 118, 118, 118)),//Chat Vender/Rechazar Text
  ),
  );

  static final ThemeData darkTheme = ThemeData(

    scaffoldBackgroundColor: _darkWall,
    backgroundColor:  _darkWall,
    accentColor: Color.fromARGB(255, 254, 189, 16),
    hintColor: Color.fromARGB(255, 70, 70, 70),// fondo textfields sin apretar
    focusColor:  _darkWall,// fondo textfields apretados
    hoverColor: Colors.black,
    dialogBackgroundColor: Color.fromARGB(255, 22, 22, 22),
    dividerColor: Color.fromARGB(40, 132, 111, 56),

    /* appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),*/
    cardTheme: CardTheme(
     color: Color.fromARGB(255, 70, 70, 70),
    ),
    cardColor: Color.fromARGB(255, 255, 213, 104),
    primaryIconTheme: IconThemeData(
        color: Colors.red,
        size: 12
    ),
    iconTheme: IconThemeData(
      color: Colors.white70,
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
        color: Colors.white,
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
        ),//texto de botones,
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontFamily: "Sf",
        fontWeight: FontWeight.w700,
    ),//Titulos de configuracion
      subtitle1: TextStyle(
      color: Colors.white70,
      fontSize: 20,
      fontFamily: "Sf",
      fontWeight: FontWeight.w600,
    ), //Subtitulos de configuracion
      subtitle2: TextStyle(
        color: Colors.white54,
        fontSize: 15,
        fontFamily: "Sf",
        fontWeight: FontWeight.w400,
      ), //SubSubtitulos de configuracion
    ),//Configuracion Style
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: "Sf",
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 30,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: "Sf-r",
        fontWeight: FontWeight.w700,
      ), //Tile Book Name
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontFamily: "Sf",
        fontWeight: FontWeight.w500,
      ),//Tile Author Name
      headline4:  TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: "Sf-r",
        color: Color.fromARGB(
            190, 255, 255, 255),
      ),//Tile User Name
      headline5: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        fontFamily: "Sf-r",
        color: Color.fromARGB(200, 255, 255, 255),
      ),//Tile Estado
      subtitle1: TextStyle(
        fontFamily: "Sf-r",
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),//Texto de los tiles

    ),
    accentTextTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: "Sf",
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 30,
      ), // Headline PageView
      headline2: TextStyle(
        fontFamily: "Sf",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),//User Name NotificationView
      headline3: TextStyle(
        fontFamily: "Sf",
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.white60,
      ),//Last Message NotificationView
      headline4: TextStyle(
          fontFamily: "Sf-r",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white),//Chat Vender/Rechazar Text
    )
  );
}
