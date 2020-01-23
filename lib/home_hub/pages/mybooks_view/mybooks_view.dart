import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/catergory_selector.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/editing_yourbook.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/primera_subir_foto.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';

class MyBooksView extends StatefulWidget {
  @override
  MyBooksViewState createState() => MyBooksViewState();
}

class MyBooksViewState extends State<MyBooksView> {
  static Widget gridViewPublicados = GridViewPublicados();
  static Widget gridViewVendidos = GridViewVendidos();

  Widget gridView = gridViewPublicados;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,

        ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrimeraSubirFoto(),
              ),
            );
          }
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: AppColors.secondaryBackground,
                margin: EdgeInsets.only(left: 22, top: 120),
                child: Text(
                  "Mis libros",
                  style: TextStyle(
                    fontFamily: "Gibson",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                  ),
                ),
              ),
              Container(
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
              )
            ],
          ), //Cartelito "Mis Libros"
          CategorySelector(this),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 22, right: 22, top: 22),
                  child: gridView,
                )),
          )
        ],
      ),
    );
  }

  void changeFunction(int index) {
    if (index == 0) {
      setState(() {
        gridView = gridViewPublicados;
      });
    } else {
      setState(() {
        gridView = gridViewVendidos;
      });
    }
  }
}

class GridViewPublicados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              Book book = books[index];

              return Container(
                height: SizeConfig.blockSizeVertical * 10,
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 20,
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 8,
                        width: 97,
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
                            builder: (context) => EditingYourBook(
                              book: book,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image(
                                height: 141,
                                width: 97,
                                image: AssetImage(book.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: 43,
                                  height: 25,
                                  child: FlatButton(
                                      color: Colors.white,
                                      padding: EdgeInsets.only(top: 0, right: 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                                      ),
                                      textColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      child: Text(
                                        '\$${book.price}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Gibson",
                                          color: AppColors.secondaryBackground,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      onPressed: () {}),
                                ),
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
            childCount: books.length,
          ),
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //   maxCrossAxisExtent: 200.0,
          //   mainAxisSpacing: 10.0,
          //   crossAxisSpacing: 10.0,
          //   childAspectRatio: 4.0,
          // ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 0.49,
          ),
        ),
      ],
    );
  }
}

class GridViewVendidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              Book book = books[index];

              return Container(
                height: SizeConfig.blockSizeVertical * 10,
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 20,
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 8,
                        width: 97,
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
            childCount: books.length,
          ),
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //   maxCrossAxisExtent: 200.0,
          //   mainAxisSpacing: 10.0,
          //   crossAxisSpacing: 10.0,
          //   childAspectRatio: 4.0,
          // ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 0.49,
          ),
        ),
      ],
    );
  }
}
