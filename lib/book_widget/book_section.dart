import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';

class BookSection extends StatefulWidget {
  void onBtnBlueTwoPressed(BuildContext context) {}

  void onBtnBluePressed(BuildContext context) {}


  final Book book;

  BookSection({this.book});

  @override
  _BookSectionState createState() => _BookSectionState();
}

class _BookSectionState extends State<BookSection> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: SizeConfig.blockSizeVertical * 23,
              left: 0,
              right: 0,
              bottom: 0,
              child: verticalListView(widget.book),
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.blockSizeVertical * 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 22,
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
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.star_border),
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
                            color: Colors.pink,
                            width: SizeConfig.blockSizeHorizontal * 80,
                            height: SizeConfig.blockSizeVertical * 10,
                            margin: EdgeInsets.only(left: 22, top: 130),
                            child: Text(
                              widget.book.name,
                              style: TextStyle(
                                fontFamily: "Gibson",
                                color: AppColors.accentText,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 80,
                            height: SizeConfig.blockSizeVertical * 5,
                            color: Colors.blue,
                            margin: EdgeInsets.only(left: 22, top: 5),
                            child: Text(
                              widget.book.author,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: AppColors.accentText,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 15,
              height: 53,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ]),
                        child: FlatButton(
                            color: AppColors.secondaryElement,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(24)),
                            ),
                            textColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 25,
                                ),

                                Container(
                                  width: 2,
                                  height: 25,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                ),
                                Text(
                                  '\$${widget.book.price}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeHub())
                              );
                            }),

                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 20,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ]),
                        child: FlatButton(

                            color: Colors.black54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(24)),

                            ),
                            textColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeHub())
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  static Widget verticalListView(Book book) {
    return Container(
      height: SizeConfig.blockSizeVertical * 100,
      margin: EdgeInsets.all(0),
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {

          return Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      horizontalListView(book),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          height: 60,
                          width: 200,
                          color: Colors.purple,
                          margin: EdgeInsets.only(
                            top: 12,
                            left: 22,
                          ),

                          child: Text(
                            '\$${book.price}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 31,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Montserrat",
                              color: Color.fromARGB(190, 0, 0, 0),
                            ),
                          )
                      ),
                      Container(
                        height: 2,
                        margin: EdgeInsets.only(left: 22, top: 25, right: 22),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(77, 0, 0, 0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget horizontalListView(Book book) {
    return Container(
      height: 185,
      margin: EdgeInsets.only(left: 22, top: 60),
      color: Colors.blue,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {

          return Container(
            margin: EdgeInsets.all(0),
            width: 429,
            color: Colors.red,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 123,
                        child: Image(
                          image: AssetImage(book.imageUrl),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        height: 180,
                        width: 123,
                        margin: EdgeInsets.only(left: 20),
                        child: Image(
                          image: AssetImage(book.imageUrl),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        height: 180,
                        width: 123,
                        margin: EdgeInsets.only(left: 20),
                        child: Image(
                          image: AssetImage(book.imageUrl),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
