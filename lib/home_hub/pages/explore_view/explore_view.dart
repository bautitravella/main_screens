import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ExploreView extends StatefulWidget {
  ExploreView({Key key}) : super(key: key);
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            height: SizeConfig.blockSizeVertical * 100,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: SizeConfig.blockSizeVertical * 15,
                  right: 0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 45,
                      child: Image.asset(
                        "assets/images/destacados-image.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.blockSizeVertical * 12,
                  left: 28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explorar",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 8,
                      ),
                      categoryScroll,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 47,
                    minHeight: SizeConfig.blockSizeVertical * 47,
                    color: Colors.transparent,
                    backdropEnabled: false,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.transparent,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          right: 25,
          child: Row(
            children: <Widget>[
              Icon(Icons.search,color: Colors.white, size: 26),
              SizedBox(width: 5,
              ),
              Icon(Icons.more_vert, color: Colors.white, size: 26)
            ],
          ),
        ),
        Positioned(
          top: 35,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: ListView(
                scrollDirection: Axis.vertical,
                controller: sc,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                        height: 151.0,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            "assets/images/explora-seleccion-grande.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        bottom: 50,
                        width: SizeConfig.blockSizeHorizontal * 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Recomendados",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: "Sf-r",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Nuestra selección \nexclusiva para vos",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        height: 151.0,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            "assets/images/explora-economicos.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        bottom: 50,
                        width: SizeConfig.blockSizeHorizontal * 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Economicos",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: "Sf-r",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Seleccion de libros con \nlos mejores precios",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget categoryScroll = Container(
    height: 120,
    width: SizeConfig.blockSizeHorizontal * 92,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 213, 104),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    MaterialIcons.school,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                "Colegios",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 213, 104),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.class_,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                "Materias",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 213, 104),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.group,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                "Cursos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 213, 104),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    FontAwesome5.address_book,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                "Usuarios",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 213, 104),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30,
                  )),
              Text(
                "Porongas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Sf-r",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
