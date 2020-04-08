import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/home_hub/pages/explore_view/categories/categories_colegios.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/your_book.dart';
import 'package:flutterui/home_hub/search_widget/search_widget.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/blocs/bloc.dart';


class FavoritosView extends StatefulWidget {
  FavoritosView({Key key}) : super(key: key);
  @override
  _FavoritosViewState createState() => _FavoritosViewState();
}

class _FavoritosViewState extends State<FavoritosView> {

  @override
  void initState(){
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/favoritos");
  }

  Widget build(BuildContext context) {
    //BlocProvider.of<FavoritesBloc>(context).add(AddBookToFavorites("iex5V1rNdY0FVX2y9f7P"));
//    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context);
//    analytics.setCurrentScreen(screenName: "/home/favoritos");
    SizeConfig().init(context);
    return Scaffold(
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
                    "Favoritos",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Sf",
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
                    panelBuilder: (ScrollController sc) =>
                        _scrollingList(sc, context),
                    maxHeight: SizeConfig.blockSizeVertical * 61.2,
                    minHeight: SizeConfig.blockSizeVertical * 61.2,
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
                  right: 20,
                  top: 45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MiPerfil(),
                        ),
                      );
                    },
                    child: BlocBuilder<UserBloc,UserBlocState>(
                      builder: (context,state){
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

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollingList(ScrollController sc, BuildContext context) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Hero(
        tag: "Targeta sube",
        child: Stack(children: <Widget>[
          Positioned(
            top: 0,
            right: 25,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.search), iconSize: 26, color: Colors.white, onPressed:() {
                  BlocProvider.of<BooksBloc>(context).add(LoadUserBooks());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchWidget(),
                    ),
                  );
                },),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    child: Icon(Icons.more_vert, color: Colors.white, size: 26),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MiPerfil(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Positioned(
            top: 45,
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
                child: BlocBuilder<FavoritesBloc, FavoritesBlocState>(
                    builder: (context, state) {
                  if (state is FavoriteBooksLoaded) {
                    if(state.books == null || state.books.length == 0){
                      return  ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                                height: SizeConfig.blockSizeVertical*52,
                                width: SizeConfig.blockSizeHorizontal * 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset(
                                    "assets/images/no-favorites-long.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 30,
                                bottom: 50,
                                width: SizeConfig.blockSizeHorizontal * 90,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "¡Que esperas!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontFamily: "Sf-r",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        "Puedes agregar libros en\nlos que estés interesado.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Sf-t",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    }
                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        controller: sc,
                        slivers: <Widget>[
                          SliverGrid(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150.0,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 0,
                              childAspectRatio: 0.53,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                Book book = state.books[index];

                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 5, right: 5, top: 0, bottom: 17),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${book.nombreLibro}",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily: "Sf-r",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  "(${book.autor})",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: "Sf-t",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
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
                                                  BookSection(book),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 9.0,
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
                                                  image:
                                                      book.getFirstImageThumb(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              /*Positioned(
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
                                            )*/ //Etiqueta arriba
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 7,
                                        child: Container(
                                          height: 20,
                                          width: 60,
                                          margin: EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            border: Border.all(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    205, 112, 112, 112)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '\$${book.precio}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Sf-r",
                                                color: Color.fromARGB(
                                                    205, 112, 112, 112),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              childCount:
                                  state.books == null ? 0 : state.books.length,
                            ),
                            // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            //   maxCrossAxisExtent: 200.0,
                            //   mainAxisSpacing: 10.0,
                            //   crossAxisSpacing: 10.0,
                            //   childAspectRatio: 4.0,
                            // ),

                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
              ),
            ),
          ),
        ]));
  }
}
