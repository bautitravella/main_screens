import 'package:flutter/material.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/precio_libro.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/Models/books_model.dart';

class DatosLibros extends StatefulWidget {
  @override
  _DatosLibrosState createState() => _DatosLibrosState();
}

void onLogoPressed(BuildContext context) {}
void onProfilePicture(BuildContext context) {}
void onButtonPressed(BuildContext context) {}

class _DatosLibrosState extends State<DatosLibros> {
  bool _isSelected = false;
  bool _isMarcked = false;
  bool _isTicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      iconSize: 30.0,
                      color: AppColors.accentText,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 28, top: 24),
              child: Text(
                "Vender",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Gibson",
                  color: AppColors.accentText,
                  fontWeight: FontWeight.w600,
                  fontSize: 38,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
              child: ListView(
                children: <Widget>[
                  Container(
                    width: 50,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 8,
                        right: SizeConfig.blockSizeHorizontal * 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 141,
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 97,
                                    child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            height: 141,
                                            width: 97,
                                            image: AssetImage(
                                                "assets/images/bookdescarte.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 6.0,
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        100)

                                            ),
                                            child: OutlineButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                borderSide: BorderSide(color: AppColors.secondaryBackground, width: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColors
                                                      .secondaryBackground,
                                                  size: 20,
                                                ),
                                                onPressed: () {}),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: 97,
                                      child: Stack(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image(
                                              height: 141,
                                              width: 97,
                                              image: AssetImage(
                                                  "assets/images/bookdescarte.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 6.0,
                                                    )
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                  new BorderRadius.circular(
                                                      100)

                                              ),
                                              child: OutlineButton(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  borderSide: BorderSide(color: AppColors.secondaryBackground, width: 2),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(100)),
                                                  ),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: AppColors
                                                        .secondaryBackground,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {}),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 97,

                                    child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: Image(
                                            height: 141,
                                            width: 97,
                                            image: AssetImage(
                                                "assets/images/bookdescarte.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 6.0,
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                new BorderRadius.circular(
                                                    100)

                                            ),
                                            child: OutlineButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                borderSide: BorderSide(color: AppColors.secondaryBackground, width: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(100)),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColors
                                                      .secondaryBackground,
                                                  size: 20,
                                                ),
                                                onPressed: () {}),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            "Completa los datos \ndel libro",
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Asegúrate de escribir correctamente \nlos datos del libro que vallas a vender.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 45,
                                margin: EdgeInsets.only(top: 40),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "NOMBRE",
                                      contentPadding: EdgeInsets.only(top: 30),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 1,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                              Container(
                                color: Color.fromARGB(255, 69, 79, 99),
                                height: 2,
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 0),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "AUTOR",
                                      contentPadding: EdgeInsets.only(top: 30),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 1,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                              Container(
                                color: Color.fromARGB(255, 69, 79, 99),
                                height: 2,
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 0),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "EDITORIAL",
                                      contentPadding: EdgeInsets.only(top: 30),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 1,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                              Container(
                                color: Color.fromARGB(255, 69, 79, 99),
                                height: 2,
                              ),
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 0),
                                child: Opacity(
                                  opacity: 0.63,
                                  child: TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "ISBN",
                                      contentPadding: EdgeInsets.only(top: 30),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color.fromARGB(180, 69, 79, 99),
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 1,
                                    autocorrect: false,
                                  ),
                                ),
                              ),
                              Container(
                                color: Color.fromARGB(255, 69, 79, 99),
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Text(
                            "Comenta sobre el \nlibro",
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Escribe una breve descripción \ndel estado en el que se encuentra el libro a vender.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 38, 65),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Container(
                          height: 205,
                          margin: EdgeInsets.only(top: 20),
                          child: ListView(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: "ESTADO",
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 69, 79, 99),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                        height: 2.1),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    autocorrect: true,
                                  ),
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 50),
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 40),
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 40),
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 40),
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 40),
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 40),
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 69, 79, 99),
                                          height: 2,
                                          margin: EdgeInsets.only(top: 40),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6, right: 4, top: 15),
                          child: CheckboxListTile(
                            title: const Text(
                              'Dale "tick" si es que el libro es nuevo',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(180, 69, 79, 99),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            value: _isSelected,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isSelected = newValue;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 30),
                          alignment: Alignment.center,
                          child: Text(
                            "ESTE LIBRO SE PUBLICARA...",
                            style: TextStyle(
                              color: Color.fromARGB(180, 69, 79, 99),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                              letterSpacing: -0.41786,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(left: 0),
                          child: CheckboxListTile(
                            title: const Text(
                              'Solo se publicara el libro dentro del colegio predeterminado.',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(180, 69, 79, 99),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            value: _isMarcked,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isMarcked = newValue;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: CheckboxListTile(
                            title: const Text(
                              'Se publicara en  todos los colegios.',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(180, 69, 79, 99),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            value: _isTicked,
                            onChanged: (bool newValue) {
                              setState(() {
                                _isTicked = newValue;
                              });
                            },
                          ),
                        ),
                        Center(
                          child: Container(
                              width: 215,
                              height: 100,
                              margin:
                                  EdgeInsets.only(left: 4, right: 4, top: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.attach_money,
                                    size: 60.0,
                                    color: Color.fromARGB(255, 112, 112, 112),
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 35,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: "PRECIO",
                                            hintStyle: TextStyle(
                                              color:
                                                  Color.fromARGB(20, 0, 0, 0),
                                            ),
                                            contentPadding:
                                                EdgeInsets.only(top: 20),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 112, 112, 112),
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30,
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        child: Container(
                                          color: Color.fromARGB(
                                              105, 112, 112, 112),
                                          height: 2,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 44,
                    margin: EdgeInsets.only(
                        bottom: 20,
                        top: 30,
                        left: SizeConfig.blockSizeHorizontal * 65),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrecioLibro()),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

void main() {
  runApp(new MaterialApp(
      home: new DatosLibros(), debugShowCheckedModeBanner: false));
}
