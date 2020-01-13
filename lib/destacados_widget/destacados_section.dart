import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';

class DestacadosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                top: SizeConfig.blockSizeVertical * 25,
                child: Container(
                  height: 220,
                  margin: EdgeInsets.all(0),
                  color: Colors.blue,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: books.length,
                    itemBuilder: (BuildContext context, int index) {
                      Book book = books[index];

                      return Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 5, 20, 5),
                            height: 170.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(100, 20, 20, 20),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[Text(book.name)],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(book.author),
                                      Container(
                                        height: 20,
                                        width: 50,
                                        color: Color.fromARGB(80, 0, 0, 0),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          height: 40,
                                          width: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                                "assets/images/avatar.png"),
                                          )),
                                      Container(
                                        height: 20,
                                        width: 50,
                                        color: Color.fromARGB(80, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 15,
                            bottom: 15,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                width: 110,
                                image: AssetImage(
                                  book.imageUrl,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.blockSizeVertical * 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                iconSize: 30.0,
                                color: Colors.black,
                                onPressed: () => Navigator.pop(context),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "LIBROS",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: AppColors.accentText,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.sort),
                                iconSize: 30.0,
                                color: Colors.black,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 22, top: 130),
                            child: Text(
                              "Destacados",
                              style: TextStyle(
                                fontFamily: "Gibson",
                                color: AppColors.accentText,
                                fontWeight: FontWeight.w600,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
