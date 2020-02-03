import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/destacados_widget/destacados_section.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/mybooks_view.dart';
import 'package:flutterui/perfiles_widgets/perfil_alguien.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeViewDos extends StatefulWidget {
  HomeViewDos({Key key}) : super(key: key);
  @override
  _HomeViewDosState createState() => _HomeViewDosState();
}

class _HomeViewDosState extends State<HomeViewDos> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: SizeConfig.blockSizeVertical * 8,
                  right: 0,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      "assets/images/home-view-image.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 52,
                  child: Container(
                      height: 31,
                      child: Image.asset(
                        "assets/images/buymy-whitelogo-dos.png",
                        fit: BoxFit.fitHeight,
                      )),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: SizeConfig.blockSizeVertical * 14,
              ),
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 80,
                    minHeight: SizeConfig.blockSizeHorizontal * 115,
                    backdropEnabled: false,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
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
                          "assets/images/round-underpic-shade.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: SizeConfig.blockSizeHorizontal * 4,
                    top: SizeConfig.blockSizeVertical * 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PerfilAlguien(),
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 2, //
                            ),
                            borderRadius: new BorderRadius.circular(100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/avatar.png",
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: SizeConfig.blockSizeVertical * 73,
                  child: SingleChildScrollView(
                    controller: sc,
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 246, 246, 246),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      )),
                                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DestacadosSection()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "LIBROS DESTACADOS",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 57, 57, 57),
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
                                            color: Color.fromARGB(
                                                255, 251, 187, 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14)),
                                            ),
                                            child: Text(
                                              "VER TODO",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w900,
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
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 246, 246, 246),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      )),
                                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyBooksView()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "MIS LIBROS",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 57, 57, 57),
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
                                            color: Color.fromARGB(
                                                255, 251, 187, 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14)),
                                            ),
                                            child: Text(
                                              "VER TODO",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w900,
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
                                height: SizeConfig.blockSizeVertical * 2,
                              )
                            ],
                          ),
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
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = books[index];

        return Container(
          margin: EdgeInsets.all(7.0),
          width: 97,
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
                            fontSize: 11,
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
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 25,
                  width: 50,
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 235, 235),
                      borderRadius: new BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      '\$${book.price}',
                      style: TextStyle(
                        color: Color.fromARGB(105, 0, 0, 0),
                        fontSize: 12,
                        fontFamily: "Gibson",
                        fontWeight: FontWeight.w600,
                      ),
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
