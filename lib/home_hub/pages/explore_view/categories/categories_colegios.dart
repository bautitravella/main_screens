import 'package:flutter/material.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/Models/school_model.dart';
import 'package:flutterui/Models/user_model.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:palette_generator/palette_generator.dart';

class CategoriesColegios extends StatefulWidget {
  CategoriesColegios({Key key}) : super(key: key);
  @override
  _CategoriesColegiosState createState() => _CategoriesColegiosState();
}

class _CategoriesColegiosState extends State<CategoriesColegios> {

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: SizeConfig.blockSizeVertical * 10,
                  right: 0,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 45,
                    child: Image.asset(
                      "assets/images/destacados-image.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.blockSizeVertical * 6,
                  left: 24,
                  right: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          /* IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),*/
                          Text(
                            "Colegios",
                            style: TextStyle(
                              fontFamily: "Sf-r",
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.search, color: Colors.white, size: 26),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.more_vert, color: Colors.white, size: 26)
                        ],
                      ),
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
                    maxHeight: SizeConfig.blockSizeVertical * 88,
                    minHeight: SizeConfig.blockSizeVertical * 88,
                    color: Colors.transparent,
                    backdropEnabled: false,
                    parallaxEnabled: true,
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
    return Hero(
      tag: "Targeta sube",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ //TODO poner un if dependiendo si esta un curso seleccionado o no
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 22, bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: schools.length,
              itemBuilder:(BuildContext context,int index) {
                School school = schools[index];
                return buildEtiqueta(school.imageUrl,school.name);
                },
            ),
          ),
          Expanded(
            child: Container(
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
                child: listaAlumnos(sc)
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget seleccionColegios(ScrollController sc){
    return  ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: sc,
                    itemCount: schools.length,
                    itemBuilder: (BuildContext context, int index) {
                     School school = schools[index];
                      return  Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                        height: 94,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        decoration: BoxDecoration(
                          color: Colors.grey, //TODO implementar dependencie de color palette
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal*5,
                            ),
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage(school.imageUrl),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(school.name,
                                  style: TextStyle(
                                    fontFamily: "Sf-r",
                                    color: Color.fromARGB(255, 57, 57, 57),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("13 libros subidos",  //TODO cambiar esto por el class de Firebase
                                  style: TextStyle(
                                    fontFamily: "Sf-t",
                                    color: Color.fromARGB(255, 57, 57, 57),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }); //TODO Agregar un if si el colegio esta seleccionado
  }
  Widget seleccionMaterias(ScrollController sc){
    return  ListView.builder(
        scrollDirection: Axis.vertical,
        controller: sc,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return  Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
            height: 68,
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal*5,
                ),
                Icon(Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 69, 79, 99),
                size: 20,
                ),
                SizedBox(width: 10),
                Text("Materia nose cuanto",
                  style: TextStyle(
                    fontFamily: "Sf-r",
                    color: Color.fromARGB(255, 79, 79, 79),
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),)
              ],
            ),
          );
        }); //TODO Agregar un if si el colegio esta seleccionado
  }
  Widget listalibros(ScrollController sc){
    return  ListView.builder(
      scrollDirection: Axis.vertical,
      controller: sc,
      itemCount: books2.length,
      itemBuilder: (BuildContext context, int index) {
        Book2 book = books2[index];

        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
              padding: EdgeInsets.fromLTRB(13, 13, 13, 11),
              height: 122.0,
              width: SizeConfig.blockSizeHorizontal * 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 242, 242),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 45,
                              child: Text(
                                "${book.name}",
                                style: TextStyle(
                                  color: Color.fromARGB(200, 0, 0, 0),
                                  fontSize: 16,
                                  fontFamily: "Sf-r",
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "${book.author}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: "Sf",
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.star_border),
                                  onPressed: () {},
                                )),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 14,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(20, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  book.state.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Gibson",
                                    color: Color.fromARGB(100, 0, 0, 0),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 62.5,
                              margin: EdgeInsets.only(
                                  left: 0, right: 0, bottom: 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          height: 30,
                                          width: 30,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Image.asset(
                                                "assets/images/avatar.png"),
                                          )),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 4),
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 21,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(30, 0, 0, 0),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  alignment: Alignment.center,
                                                ),
                                                Positioned(
                                                  left: 5,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        '${book.rating}',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "Sf-r",
                                                          color: Color.fromARGB(100,0, 0, 0),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: 17,
                                                        color:
                                                        Color.fromARGB(100, 0, 0, 0),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                      const EdgeInsets.only(right: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '\$${book.price}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Montserrat",
                                              color: Color.fromARGB(
                                                  190, 0, 0, 0),
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 22,
              bottom: 15,
              top: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  book.imageUrl,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget listaAlumnos(ScrollController sc){
    return  ListView.builder(
      scrollDirection: Axis.vertical,
      controller: sc,
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = users[index];

        return Container(
          margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
          height: 84,
          width: SizeConfig.blockSizeHorizontal * 100,
         /* decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 1.0,
                ),
              ]
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal*5,
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(user.imageUrl),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(user.name,
                        style: TextStyle(
                          fontFamily: "Sf-r",
                          color: Color.fromARGB(255, 116, 116, 116),
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 21,
                            width: 40,
                            decoration: BoxDecoration(
                             color: Color.fromARGB(255, 116, 116, 116),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                width: 1.0, color: Color.fromARGB(255, 235, 235, 235)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                    Icons.star,
                                    size: 17,
                                    color: Colors.white),
                                Text(
                                  '${user.rating}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Sf-r",
                                    color: Colors.white
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            height: 21,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1.0, color: Color.fromARGB(255, 235, 235, 235)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                 user.curso,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Sf-r",
                                    color: Color.fromARGB(130, 116, 116, 116),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(85, 15, 85, 0),
                height: 2,
                color: Colors.black12,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildEtiqueta(String url,String colegioName){
    return  UnconstrainedBox(
      child: Container(
        height: 32,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)
            )
        ),
        child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                height: 22,
                width: 22,
                child: Image.asset(url, fit: BoxFit.fill,),
              ),
              Text(colegioName,
                style: TextStyle(
                  fontFamily: "Sf-r",
                  color: Color.fromARGB(255, 27, 27, 27),
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  child: Icon(Icons.close, size: 22,))
            ]
        ),
      ),
    );
  }
}
