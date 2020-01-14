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
              top: SizeConfig.blockSizeVertical * 23,
              left: 0,
              right: 0,
              bottom: 0,
              child: verticalListView,
            ),
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

  static Widget verticalListView = Container(
    height: 220,
    margin: EdgeInsets.all(0),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = books[index];

        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(45, 5, 20, 5),
              height: 120.0,
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
                padding: EdgeInsets.fromLTRB(70, 10, 20, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Text(
                            "${book.name}",
                            style: TextStyle(
                              fontSize: 18,
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
                          width: 150,
                          child: Text(
                            "${book.author}",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                          color: Color.fromARGB(80, 0, 0, 0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                          alignment: Alignment.center,
                          child: Text(
                            book.state.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Gibson",
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(

                      children: <Widget>[
                        Container(
                            height: 40,
                            width: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/avatar.png"),
                            )),
                        Row(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 21,
                                  width: 50,

                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(80, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Row(

                                  children: <Widget>[
                                    Text('${book.rating}'),
                                    Icon(
                                      Icons.star,
                                      size: 15,
                                      color: Color.fromARGB(150, 0, 0, 0),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),


                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          iconSize: 25.0,
                          color: Colors.black54,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.star_border),
                          iconSize: 25.0,
                          color: Colors.black54,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text('\$${book.price}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 22,
              bottom: 5,
              top: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
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
  );
}
