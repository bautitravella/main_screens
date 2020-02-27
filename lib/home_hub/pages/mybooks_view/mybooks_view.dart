import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/book_widget/book_section_chota.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/catergory_selector.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/subir_foto_libro.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/your_book.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';

class MyBooksView extends StatefulWidget {
  @override
  MyBooksViewState createState() => MyBooksViewState();
}

class MyBooksViewState extends State<MyBooksView> {


  List<Book>  publicados ;
  List<Book>  vendidos ;

  Widget gridView ;

  @override
  Widget build(BuildContext context) {
    return // BlocBuilder<UserBooksBloc,UserBooksBlocState>(
//      builder: (context,state) {
//
//        if(state is User)
//      },
//      child:
      Scaffold(
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
                  builder: (context) => SubirFotoLibro(),
                ),
              );
            }
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  top: SizeConfig.blockSizeVertical * 12,
                  left: 28,
                  child: Text(
                    "Mis libros",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
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
                      ),
                      Positioned(
                        right: SizeConfig.blockSizeHorizontal*4,
                        top: SizeConfig.blockSizeVertical*5,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2, //
                                ),
                                borderRadius:
                                new BorderRadius.circular(
                                    100)
                            ),
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
                    child: BlocBuilder<UserBooksBloc,UserBooksBlocState>(
                      builder: (context,state) {
                        if(state is UserBooksLoadedState){
                            publicados = state.publicados;
                            vendidos = state.vendidos;

                          return gridView == null? GridViewPublicados(publicados): gridView;

                        }else if(state is UserBooksLoadingState){
                          return Center(child: CircularProgressIndicator());
                        }
                        return LinearProgressIndicator();
                      },
                    ),
                  )),
            )
          ],
        ),
      );
    //   )
    ;
  }

  void changeFunction(bool isPublicado) {



    if (isPublicado) {
      setState(() {
        if(publicados!= null) gridView = GridViewPublicados(publicados);
      });
    } else {
      setState(() {
        if(vendidos != null)  gridView = GridViewVendidos(vendidos);
      });
    }
  }
}

class GridViewPublicados extends StatelessWidget {

  List<Book> books;

  GridViewPublicados(this.books);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  books == null || books.length == 0 ? Center(child: Text("parece que no hay ningun libro cargado en esta categoria"),):  CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              Book book = books[index];

              return Container(
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 150,
                      child: Container(
                        height: 65,
                        width: 97,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${book.nombreLibro}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: "Sf",
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                "(${book.autor})",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Sf",
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
                              //todo cambiar esta refencia por una de su propio libro
                              book: books2[0],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
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
                              borderRadius: BorderRadius.circular(5),
                              child://book.images[0],
                              Image(
                                height: 141,
                                width: 97,
                                image: book.images[0],
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
                                        '\$${book.precio}',
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

  List<Book> books;

  GridViewVendidos(this.books);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO crear alguna ilustracion para cuando no haya ningun libro publicado
    return  books == null || books.length == 0 ? Center(child: Text("parece que no hay ningun libro cargado en esta categoria"),): CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              Book book = books[index];

              return Container(
                height: SizeConfig.blockSizeVertical * 10,
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                color: Colors.red,
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
                                "${book.nombreLibro}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                "(${book.autor})",
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
                            builder: (context) => BookSectionChota(
                                books2[0]),
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
                                image: book.images[0],
                                fit: BoxFit.cover,
                              ),    //book.images[0],

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
