import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class DestacadosSectionDos extends StatefulWidget {
  DestacadosSectionDos({Key key}) : super(key: key);
  @override
  _DestacadosSectionDosState createState() => _DestacadosSectionDosState();
}

class _DestacadosSectionDosState extends State<DestacadosSectionDos> {
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
                  top: SizeConfig.blockSizeVertical * 8,
                  right: 0,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      "assets/images/destacados-image.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 52,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          "Destacados",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    maxHeight: SizeConfig.blockSizeVertical * 90,
                    minHeight: SizeConfig.blockSizeVertical * 90,
                    backdropEnabled: false,
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
    return Container(
      height: 220,
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: FadingEdgeScrollView.fromScrollView(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: sc,
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            Book book = books[index];

            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  padding: EdgeInsets.all(13),
                  height: 132.0,
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
                                      fontFamily: "Gibson",
                                      fontWeight: FontWeight.w600,
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
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
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
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 62.5,
                            margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  color:
                                                      Color.fromARGB(30, 0, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                alignment: Alignment.center,
                                              ),
                                              Positioned(
                                                left: 5,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${book.rating}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "Montserrat",
                                                        color: Color.fromARGB(
                                                            100, 0, 0, 0),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 17,
                                                      color: Color.fromARGB(
                                                          100, 0, 0, 0),
                                                    ),
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
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '\$${book.price}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "Montserrat",
                                            color: Color.fromARGB(190, 0, 0, 0),
                                          ),
                                        )
                                      ],
                                    )),
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
                    child: Image(
                      height: 120,
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
      ),
    );
  }
}
