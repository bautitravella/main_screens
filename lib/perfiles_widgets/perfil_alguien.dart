import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/your_book.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';


class PerfilAlguien extends StatefulWidget {

  @override
  PerfilAlguienState createState() => PerfilAlguienState();
}

class PerfilAlguienState extends State<PerfilAlguien> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            color: AppColors.secondaryBackground,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(Icons.school),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30.0,
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35),
                      bottomLeft: Radius.circular(35)),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(0),
                  height: SizeConfig.blockSizeVertical * 86.42,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: verticalListView)
            ],
          )
        ],
      ),
    );
  }
}

Widget verticalListView = Container(
  child: SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          height: 280,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 10.0,
                )
              ]),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Hero(
                            tag: 'profile',
                            child: Image.asset(
                              "assets/images/avatar.png",
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(left: 60, top: 50),
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  height: 30,
                  child: Text(
                    "Andres Latania",
                    style: TextStyle(
                      color: Color.fromARGB(255, 57, 57, 57),
                      fontFamily: "Gibson",
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 0),
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Senior 2, Sociales",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Robot",
                          color: Color.fromARGB(255, 118, 118, 118),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Icon(
                              Icons.book,
                              size: 15,
                              color: Color.fromARGB(255, 180, 180, 180),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "54",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 103, 103, 103),
                                    fontFamily: "Gibson",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Vendidos",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontFamily: "Gibson",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Icon(
                              Icons.star_border,
                              size: 15,
                              color: Color.fromARGB(255, 180, 180, 180),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 103, 103, 103),
                                    fontFamily: "Gibson",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Calificación",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontFamily: "Gibson",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Sus libros",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 57, 57),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 98,
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: null,
                            disabledColor: AppColors.secondaryBackground,
                            color: Color.fromARGB(255, 251, 187, 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            child: Text(
                              "VER TODO",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                height: 450,
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal*7,
                    right: SizeConfig.blockSizeHorizontal*7,
                ),
                child: CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: <Widget>[
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Book2 book = books[index];

                          return Container(
                            height: SizeConfig.blockSizeVertical * 10,
                            margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                            padding: EdgeInsets.only(left: 0, right: 0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => YourBook(
                                          book: book,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1.0, 2.0),
                                            blurRadius: 6.0,
                                          )
                                        ]),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))),
                                                  textColor: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  child: Text(
                                                    '\$${book.price}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Gibson",
                                                      color: AppColors
                                                          .secondaryBackground,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          child: Column(
            children: <Widget>[
              Container(
                  height: 55,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Otras personas \nde su mismo curso",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 57, 57),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 98,
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: null,
                            disabledColor: AppColors.secondaryBackground,
                            color: Color.fromARGB(255, 251, 187, 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            child: Text(
                              "EXPLORA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Row(
                children: <Widget>[profileScroll],
              )
            ],
          ),
        ),
      ],
    ),
  ),
);


Widget profileScroll = Container(
  height: 70,
  width: SizeConfig.blockSizeHorizontal * 92,
  margin: EdgeInsets.only(left: 27, right: 0),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book2 book = books[index];

        return AspectRatio(
          aspectRatio: 30 / 30,
          child: Container(
              margin: EdgeInsets.all(6.0),
              width: 30,
              height: 30,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  book.imageUrl,
                  fit: BoxFit.fill,
                ),
              )),
        );
      },
    ),
);

