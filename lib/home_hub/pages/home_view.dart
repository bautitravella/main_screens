import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/destacados_widget/destacados_section.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        padding: EdgeInsets.all(0),
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Stack(
          children: <Widget>[
            Container(
                height: 110,
                width: SizeConfig.blockSizeHorizontal * 100,
                color: AppColors.secondaryBackground,
                padding: EdgeInsets.only(left: 0, right: 0, top: 0)),
            new ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) =>
                    homeViewItems(context, index)),
            Container(
              child: Container(
                height: 143,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 138,
                          height: 143,
                          child: Image.asset(
                            "assets/images/round-underpic.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget homeViewItems(BuildContext context, int index) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: 800,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: SizeConfig.blockSizeVertical * 30,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    "assets/images/photo-85889-landscape-850x566.png",
                                    fit: BoxFit.fill,
                                    color: Color.fromARGB(80, 0, 0, 0),
                                    colorBlendMode: BlendMode.darken,
                                  ),
                                ),
                              ), //BackgroudHeader
                              Positioned(
                                  left: null,
                                  right: null,
                                  top: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                "assets/images/buymy-whitelogo.png"),
                                            fit: BoxFit.cover,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Text(
                                              "Todos los libros en\nun solo lugar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                                height: 0.92308,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            child: Text(
                                              "!Encontralos ya!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Container(
                            height: 55,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),

                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DestacadosSection()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 21),
                                    child: Text(
                                      "LIBROS DESTACADOS",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 57, 57, 57),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 98,
                                    alignment: Alignment.centerRight,
                                    child: FlatButton(
                                      onPressed: null,
                                      disabledColor:
                                          AppColors.secondaryBackground,
                                      color: Color.fromARGB(255, 251, 187, 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(14)),
                                      ),
                                        child: Text(
                                          "VER TODO",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        horizontalListView,
                        Container(
                            height: 55,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),

                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyBooksView()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 21),
                                    child: Text(
                                      "MIS LIBROS",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 57, 57, 57),
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 98,
                                    alignment: Alignment.centerRight,
                                    child: FlatButton(
                                      onPressed: null,
                                      disabledColor:
                                          AppColors.secondaryBackground,
                                      color: Color.fromARGB(255, 251, 187, 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(14)),
                                      ),
                                        child: Text(
                                          "VER TODO",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        horizontalListView,
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  static Widget horizontalListView = Container(
    height: 240,
    margin: EdgeInsets.only(left: 27),
    color: Colors.blue,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = books[index];

        return Container(
          margin: EdgeInsets.all(7.0),
          width: 97,
          color: Colors.red,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: Container(
                  height: 80,
                  width: 97,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${book.name}",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          "(${book.author})",
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookSection(
                        book: book,
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          height: 141,
                          width: 97,
                          image: AssetImage(book.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
