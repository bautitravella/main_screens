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
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
        body: Stack(
          children: <Widget>[
            Container(
              color: AppColors.secondaryBackground,
              height: SizeConfig.blockSizeVertical * 100,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: SizeConfig.blockSizeVertical * 15,
                    right: 0,
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 45,
                        child: Image.asset(
                          "assets/images/destacados-image.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: SlidingUpPanel(
                      panelBuilder: (ScrollController sc) => _scrollingList(sc,context),
                      maxHeight: SizeConfig.blockSizeVertical * 73,
                      minHeight: SizeConfig.blockSizeVertical * 67,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.transparent,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                  ),
                ),
              ],
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
                            builder: (context) => MiPerfil(),
                          ),
                        );
                      },
                      child:BlocBuilder<UserBloc,UserBlocState>(
                          builder: (context,state) {
                            if(state is UserLoadedState){
                              return Container(
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
                                  child: Hero(
                                    tag: 'avatar',
                                    child: Image(
                                      image: state.user.getProfileImage(),
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();

                          }
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    //   )
    ;
  }

  Widget _scrollingList(ScrollController sc, BuildContext context) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Hero(
      tag: "Targeta sube",
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 25,
            left: 25,
            child: CategorySelector(this)
          ),
          Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
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
                      )
                    ),
                  ),
                ),



        ],
      ),
    );
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
    return  books == null || books.length == 0 ? 
    GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubirFotoLibro(),
            ),
          );
        },
      child: Center(
        child:Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 18),
             /* color: Color.fromARGB(255, 255, 213, 104),*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Agrega libros \npara vender",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Parece que no tienes ningun\nlibro publicado para vender.\n¡Apurate! La gente espera. ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 11,
                          fontFamily: "Sf-t",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                      child: Image.asset("assets/images/add-sell.png", fit: BoxFit.fitWidth))
                ],
              ),
            ),
            SizedBox(height: 45),
            Container(
              constraints: BoxConstraints.expand(height: SizeConfig.blockSizeVertical*28),
                child: Image.asset("assets/images/no-books.png", fit: BoxFit.fitHeight,))
          ],
        ),),
    )



        :CustomScrollView(
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
                            builder: (context) => BookSection(book),
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
                              child:book.getImages() != null && book.getImages().length > 0? //book.images[0],
                              Image(
                                height: 141,
                                width: 97,
                                image: book.getImages()[0],
                                fit: BoxFit.cover,
                              ):
                              CircularProgressIndicator(),
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
    return  books == null || books.length == 0 ?
    ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30)),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 346),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 249, 196, 55),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "No has vendido ningun libro",
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 57, 57),
                            fontSize: 17,
                            fontFamily: "Sf-r",
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Pero no te preocupes, contamos con\nalgunos tips para que te llenes de oro\nen poco tiempo",
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 57, 57),
                            fontSize: 11,
                            fontFamily: "Sf-t",
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: 230,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    child: Image.asset(
                      "assets/images/no-ventas.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            constraints: BoxConstraints.expand(height: 346),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
                color: Color.fromARGB(50, 249, 196, 55),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    Text(
                      "Tips que te pueden ayudar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 57, 57, 57),
                        fontSize: 17,
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                            height: 8.0,
                            width: 8.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 57, 57, 57),
                              shape: BoxShape.circle,
                            ),
                          ),
                        SizedBox(width: 8),
                        Text(
                            "Puede que tus precios estén muy altos,\nprueba bajar un poco tus precios.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 57, 57),
                              fontSize: 11,
                              fontFamily: "Sf-t",
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                        ),
                      ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 57, 57, 57),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Asegúrate de contestar rápido a los mensajes\nde tus compradores, y asegúrate siempre\nde ser gentil y educado.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 57, 57),
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 57, 57, 57),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Intenta ser transparente en tus publicaciones,\npara que no haya mal entendidos en las compras.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 57, 57),
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 57, 57, 57),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Intenta coordinar lugares de fácil acceso y\nde mutua comodidad al vender.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 57, 57),
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 57, 57, 57),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "La prolijidad de las fotos suele influir bastante\nen la perspectiva del comprador.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 57, 57),
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: new BoxDecoration(
                                color: Color.fromARGB(255, 57, 57, 57),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Asegúrate de escribir una descripción precisa\ndel producto que quieras vender.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 57, 57, 57),
                                fontSize: 11,
                                fontFamily: "Sf-t",
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                    ]
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        : CustomScrollView(
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
                                image: book.getFirstImageThumb(),
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
