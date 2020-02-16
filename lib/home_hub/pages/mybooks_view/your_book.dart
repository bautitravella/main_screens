import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/dialog_widget/custom_dialog.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/datos_libro.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/copy_slide_dialog/slide_popup_dialog.dart' as slideDialog;

class YourBook extends StatefulWidget {
  void onBtnBlueTwoPressed(BuildContext context) {}

  void onBtnBluePressed(BuildContext context) {}

  final Book2 book;

  YourBook({this.book});

  @override
  _YourBookState createState() => _YourBookState();
}

class _YourBookState extends State<YourBook> {
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
                          height: SizeConfig.blockSizeVertical * 19,
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
                                icon: Icon(Icons.edit),
                                iconSize: 30.0,
                                color: Colors.black,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DatosLibros(),
                                      ),
                                    );
                                  }
                              ),
                              Container(
                                color: Colors.black26,
                                height: 25,
                                width: 2,
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                iconSize: 30.0,
                                color: Colors.black,
                                onPressed: _showDialogEliminar,
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
                        width: SizeConfig.blockSizeHorizontal * 55,
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
                            color: Color.fromARGB(255, 0, 191, 131),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(24)),
                            ),
                            textColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_atm,
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
                                  "VENDIDO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Gibson",
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
                                      builder: (context) => HomeHub()));
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(24)),
                            ),
                            textColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeHub()));
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

  static Widget verticalListView(Book2 book) {
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
                      horizontalPhotos(book),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 22, left: 22, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Container(
                                width: 90,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 57, 57, 57),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.only(top: 4),
                                child: Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.equalizer,
                                        size: 30,
                                        color:
                                        Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "56",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Montserrat",
                                          color:
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 57, 57, 57),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                    ),
                                    textColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      '\$${book.price}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Montserrat",
                                        color:
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Descripción",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(255, 57, 57, 57),
                              ),
                            ),

                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  child: Text(
                                    book.description,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  child: Text(
                                    "Destalles",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Estado:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  child: Text(
                                    book.state,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    "Autor:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.only(top: 0, left: 5),
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  child: Text(
                                    book.author,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    "Editorial:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.only(top: 0, left: 5),
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  child: Text(
                                    book.editorial,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    "ISBN:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.only(top: 0, left: 5),
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  child: Text(
                                    '${book.isbn}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: SizeConfig.blockSizeHorizontal*100,
                        padding:
                        const EdgeInsets.only(right: 80, left: 80, top: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(24)),
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: Color.fromARGB(180, 118, 118, 118),
                                size: 25,
                              ),
                              Text(
                                "Compartir".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat",
                                  color: Color.fromARGB(180, 118, 118, 118),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 55,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 21),
                            child: Text(
                              "LIBROS SIMILARES",
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeHub()));
                                },
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
                          ),
                        ],
                      )),
                  horizontalListView,
                  Container(
                      height: 55,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 21),
                            child: Text(
                              "PARA VOS",
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeHub()));
                                },
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
                          ),
                        ],
                      )),
                  horizontalListView,

                ],
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget horizontalPhotos(Book2 book) {
    return Container(
      height: 185,
      margin: EdgeInsets.only(left: 22, top: 60),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(0),
            width: 429,
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
  static Widget horizontalListView = Container(
    height: 240,
    margin: EdgeInsets.only(left: 22),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        Book2 book = books[index];

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
                      builder: (context) =>
                          YourBook(
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

  void _showDialogEliminar() {
    slideDialog.showSlideDialogGrande(
      context: context,
      child: CustomDialog(
        title: "¿Seguro que quiere eliminar este libro?",
        description:
        "Este libro ya no estara disponible dentro de la aplicación",
        primaryButtonText: "Si",
        primaryButtonRoute: "/home",
        secondaryButtonText: "Cancelar",
        secondaryButtonRoute: "/home",
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }
}
