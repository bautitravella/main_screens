import 'dart:math';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterui/Models/AlumnoUniversitario.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/destacados_widget/destacados_section_dos.dart';
import 'package:flutterui/dialogs/dialog_widget/custom_dialog.dart';
import 'package:flutterui/dialogs/dialog_widget/succesfull_dialog.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/home_hub/admin_widgets.dart';
import 'package:flutterui/home_hub/generic_booklist_screen.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/search_widget/search_widget.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/test/test4rol.dart';
import 'package:flutterui/test/test_uploadimage.dart';
import 'package:flutterui/test/upload_book.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewTres extends StatefulWidget {
  HomeHubState homeHubState;
  HomeViewTres({this.homeHubState, Key key}) : super(key: key);

  bool isSelected = false;
  @override
  _HomeViewTresState createState() => _HomeViewTresState();
}

class _HomeViewTresState extends State<HomeViewTres> {
  PanelController _pc = new PanelController();
  HomeHubState homeHubState;

  @override
  void initState() {
    FirebaseAnalytics analytics =
        Provider.of<FirebaseAnalytics>(context, listen: false);
    analytics.setCurrentScreen(screenName: "/home/home_view");
    super.initState();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (widget.homeHubState != null) {
      homeHubState = widget.homeHubState;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _ParentRecomendadosButton = false;
          _ParentEconomicosButton = false;
          _ParentMateriasButton = false;
        });
        print('Unfocus');
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: SlidingUpPanel(
                  controller: _pc,
                  panelBuilder: (ScrollController sc) => _scrollingList(sc),
                  maxHeight: SizeConfig.blockSizeVertical * 86,
                  minHeight: SizeConfig.blockSizeVertical * 53,
                  color: Colors.transparent,
                  backdropEnabled: true,
                  backdropColor: AppColors.secondaryBackground,
                  body: _upperBody(),
                  parallaxEnabled: true,
                  parallaxOffset: 1.2,
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
      ),
    );
  }

  Widget _upperBody() {
    return FadeIn(
      child: Container(
        color: Theme.of(context).backgroundColor,
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
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 31,
                      margin: EdgeInsets.only(left: 28),
                      child: Image.asset(
                        "assets/images/buymy-whitelogo-dos.png",
                        fit: BoxFit.fitHeight,
                      )),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                  categoryScroll(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          right: 25,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                iconSize: 26,
                color: Colors.white,
                onPressed: () {
                  BlocProvider.of<BooksBloc>(context)
                      .add(LoadBooksByUser(ListType.recomended));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchWidget(homeHubState: homeHubState),
                    ),
                  );
                },
              ),
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
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: BlocBuilder<UserBloc, UserBlocState>(
                  builder: (context, state) {
                if (state is UserLoadedState) {
                  return ListView(
                    scrollDirection: Axis.vertical,
                    controller: sc,
                    children: <Widget>[
                      state.user is Padre
                          ? createParentLayoutRecomendados(state.user)
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GenericBookList.recomended(),
                                  ),
                                );
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                                    height: 151.0,
                                    width: SizeConfig.blockSizeHorizontal * 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        "assets/images/explora-seleccion-grande.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: SizeConfig.blockSizeVertical * 2,
                                    bottom: SizeConfig.blockSizeVertical * 2,
                                    width: SizeConfig.blockSizeHorizontal * 40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Recomendados",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "Sf-r",
                                            fontWeight: FontWeight.w800,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Nuestra selección \nexclusiva para vos",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontFamily: "Sf-t",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                      SizedBox(height: 5),
                      state.user is Padre
                          ? createParentLayoutEconomicos(state.user)
                          : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenericBookList.cheapest(),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                              height: 151.0,
                              width: SizeConfig.blockSizeHorizontal * 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "assets/images/explora-economicos.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: SizeConfig.blockSizeVertical * 2,
                              bottom: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Recomendados",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Nuestra selección \nexclusiva para vos",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: "Sf-t",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      /*HomeTile(
                        user: state.user,
                        backgroundImagePath:
                            "assets/images/explora-economicos.png",
                        title: "hola genio",
                        description: "soy un genio",
                      ),*///PARA FUTURO UPDATE
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GenericBookList.years(
                                      "Florida Day School"),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(12, 5, 0, 5),
                                  width: SizeConfig.blockSizeHorizontal * 45,
                                  height: 225,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/explora-cursos.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 28,
                                  bottom: 15,
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Cursos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Sf-r",
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Podrás elegir entre libros \nde cursos especificos",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Sf-t",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          state.user is Padre
                              ? createParentLayoutMaterias(state.user)
                              :GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GenericBookList.subject(
                                      "Florida Day School"),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 12, 5),
                                  height: 225,
                                  width: SizeConfig.blockSizeHorizontal * 45,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/explora-materias.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  bottom: 15,
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Materias",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Sf-r",
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Podrás elegir entre libros \nde materias especificas",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Sf-t",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ), //TODO para proximo update
                    ],
                  );
                }
                return CircularProgressIndicator();
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _scrollingListOpen(ScrollController sc) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Explorar",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.white, size: 26),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.more_vert, color: Colors.white, size: 26)
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DestacadosSectionDos(),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                            height: 151.0,
                            width: SizeConfig.blockSizeHorizontal * 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                "assets/images/explora-seleccion-grande.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 50,
                            bottom: 50,
                            width: SizeConfig.blockSizeHorizontal * 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Recomendados",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: "Sf-r",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Nuestra selección \nexclusiva para vos",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontFamily: "Sf-t",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                          height: 151.0,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              "assets/images/explora-economicos.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 50,
                          bottom: 50,
                          width: SizeConfig.blockSizeHorizontal * 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Economicos",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Sf-r",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Seleccion de libros con \nlos mejores precios",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontFamily: "Sf-t",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(12, 5, 0, 5),
                              width: SizeConfig.blockSizeHorizontal * 45,
                              height: 225,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "assets/images/explora-cursos.png",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 28,
                              bottom: 15,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Cursos",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Podrás elegir entre libros \nde cursos especificos",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: "Sf-t",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 12, 5),
                              height: 225,
                              width: SizeConfig.blockSizeHorizontal * 45,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "assets/images/explora-materias.png",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              bottom: 15,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Materias",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Podrás elegir entre libros \nde materias especificas",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: "Sf-t",
                                      fontWeight: FontWeight.w500,
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
            ),
          ),
        ],
      ),
    );
  } //TODO activar el fadeIn

  Widget categoryScroll(BuildContext context) {
    return Container(
      height: 120,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 28),
          GestureDetector(
            onTap: () {
              setState(() {
                homeHubState?.changeToMyBooks();
              });

//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => CategoriesColegios(),
//                ),
//              );
            },
            child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.inbox,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Mis Libros",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              homeHubState?.changeToFavorites();
            },
            child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Favoritos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              homeHubState?.changeToChats();
            },
            child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        FontAwesome5.comment,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Mensajes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MiPerfil(),
                ),
              );
            },
            child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Ajustes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _showDialogAyuda,
            child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.developer_mode,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "¡HELP!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubirLibroPrueba(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.developer_mode,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "UploadBook",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {showSchoolDialog();},

            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.developer_mode,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "test1",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _showNotificationDialog,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.developer_mode,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "foto de perfil",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateInstituition(),
              ),
            ),
            child: Container(
              margin:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 213, 104),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.inbox,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Create Instituition",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } //TODO especificarle cual de todas las categories

  void _showNotificationDialog() {
    showSlideDialogNotification(
        context: context,
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3, right: SizeConfig.blockSizeHorizontal*3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             /* CircleAvatar(
                radius: 25,
                backgroundColor: Color.fromARGB(255, 255, 213, 104),
                child: Icon(FontAwesome5Solid.comment, color: Colors.white),
              ),*/
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal*80,
                    child: Text(
                      "Milagros travella",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: SizeConfig.blockSizeHorizontal*80,
                    child: Text(
                      "Hola bauti como andas, estaba interesada en comprar the merchand of venice",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontFamily: "Sf",
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  void showSchoolDialog() {
    TextEditingController colegioNameTextEditingController = TextEditingController();
    String errorMessage = "No has ingresado ningun colegio.";
    showSlideDialogFull(
        context: context,
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*8, right: SizeConfig.blockSizeHorizontal*8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: SizeConfig.blockSizeVertical*7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Enviar solicitud para\nagregar un colegio",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado. Una vez aceptada o rechazada te enviaremos un mail con nuestra decision.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Nombre del colegio a agregar",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: colegioNameTextEditingController,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor,
                  autofocus: false,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,//REQUIRED
                  obscureText: false, //REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (text) {
                    print(text);
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(height: 40),
                Text(
                  "Curso",
                  style: Theme.of(context).textTheme.headline2,
                ),
                BeautyTextfield(
                  controller: colegioNameTextEditingController,
                  width: double.maxFinite, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor,
                  autofocus: false,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,//REQUIRED
                  obscureText: false, //REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (text) {
                    print(text);
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(height: 40),
                Text(
                  "Materias de tu año",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 8),
                Text(
                  "Podras agregar una por una las materias correspondientes de tu año",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BeautyTextfield(
                      width: SizeConfig.blockSizeHorizontal*60, //REQUIRED
                      height: 50, //REQUIRED
                      accentColor: Colors.white, // On Focus Color//Text Color
                      backgroundColor: Theme.of(context).hintColor,
                      autofocus: false,
                      maxLines: 1,
                      margin: EdgeInsets.only(top: 10),
                      cornerRadius: BorderRadius.all(Radius.circular(15)),
                      duration: Duration(milliseconds: 300),
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,//REQUIRED
                      obscureText: false, //REQUIRED
                      suffixIcon: Icon(Icons.remove_red_eye),
                      onClickSuffix: () {
                        print('Suffix Clicked');
                      },
                      onTap: () {
                        print('Click');

                      },
                      onChanged: (text) {
                        print(text);
                        widget.isSelected = false;
                      },
                      onSubmitted: (data) {
                        print(data.length);
                      },
                    ),
                    SizedBox(width: 10),

                  FlatButton(child: Icon(Icons.move_to_inbox, size: 30, color: Theme.of(context).iconTheme.color,), onPressed:  (){},)
                  ],
                ),
                SizedBox(height: 25),
                 Wrap(
                   children: [
                        Container(
                          margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                          child: Chip(
                            label: Text( "Environmental Management", textAlign: TextAlign.center),
                            labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                            deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                            onDeleted: (){},
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            labelStyle:  TextStyle(
                              fontFamily: "Sf-r",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).dialogBackgroundColor),
                            backgroundColor: AppColors.secondaryBackground,
                          ),
                        ),
                     Container(
                       margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                       child: Chip(
                         label: Text( "Physics high", textAlign: TextAlign.center),
                         labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                         deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                         onDeleted: (){},
                         shape: RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(15.0),
                         ),
                         labelStyle:  TextStyle(
                           fontFamily: "Sf-r",
                           fontSize: 15,
                           fontWeight: FontWeight.w700,
                           color: Theme.of(context).dialogBackgroundColor),
                         backgroundColor: AppColors.secondaryBackground,
                       ),
                     ),
                     Container(
                       margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                       child: Chip(
                         label: Text( "Maths", textAlign: TextAlign.center),
                         labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                         deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                         onDeleted: (){},
                         shape: RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(15.0),
                         ),
                         labelStyle:  TextStyle(
                           fontFamily: "Sf-r",
                           fontSize: 15,
                           fontWeight: FontWeight.w700,
                           color: Theme.of(context).dialogBackgroundColor),
                         backgroundColor: AppColors.secondaryBackground,
                       ),
                     ),
                    Container(
                      margin: EdgeInsets.only( left: 5, right: 5, bottom: 5, top: 5),
                      child: Chip(
                         label: Text( "Philology", textAlign: TextAlign.center),
                         labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
                        deleteIcon: Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
                        onDeleted: (){},
                         shape: RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(15.0),
                         ),
                         labelStyle:  TextStyle(
                           fontFamily: "Sf-r",
                           fontSize: 15,
                           fontWeight: FontWeight.w700,
                           color: Theme.of(context).dialogBackgroundColor),
                         backgroundColor: AppColors.secondaryBackground,
                       ),
                    ),
                      ],
                 ),
                SizedBox(height: 80),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(child:
                    Text(
                      "Cancelar",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf-r",
                        color: Theme.of(context).iconTheme.color.withAlpha(200),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                      onPressed: ()=> Navigator.pop(context),
                    ),
                    FlatButton(child:
                    Text(
                      "Enviar",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Sf-r",
                        color: AppColors.secondaryBackground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                      onPressed: (){
                        Navigator.pop(context);
                      showSchoolDialogSent();
                      },
                    )

                  ],
                ),
                SizedBox(height:20),
              ],
            ),
          ),
        )
    );
  }
  void showSchoolDialogSent() {
    showSlideDialogChico(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
        context: context,
        child: SuccesfullDialog(title: "Felicitaciones", body: "Ya se envio la solicitud para agregar el colegio", )
    );
  }

  void _showDialogAyuda() {
    showSlideDialogGrande(
      context: context,
      child: CustomDialog.customFunctions(
        title: "Contactanos",
        description:
            "Ante cualquier problema o duda, no dudes en enviarnos un mail a \n buymy.customerservice@gmail.com",
        primaryButtonText: "Cancelar",
        primaryFunction: () {
          Navigator.pop(context);
        },
        secondaryButtonText: "Enviar Mail",
        secondaryFunction: () async {
          try {
//            if (Platform.isAndroid) {
//              AndroidIntent intent = AndroidIntent(
//                action: 'android.intent.action.MAIN',
//                category: 'android.intent.category.APP_EMAIL',
//              );
//              intent.launch().catchError((e) {
//                print(e.message);
//              });
//            } else if (Platform.isIOS) {
//              //launch("message://")
            launch("mailto:buymy.customerservice@gmail.com?subject=Duda/Consulta BuyMy&body=Estimados,les notifico que me ocurrio ...")
                .catchError((e) {
              print(e.message);
            });
            // }
          } catch (e) {
            print(e.message);
          }
        },
      ),
      // barrierColor: Colors.white.withOpacity(0.7),
      // pillColor: Colors.red,
      // backgroundColor: Colors.yellow,
    );
  }

  bool _ParentRecomendadosButton = false;
  bool _ParentEconomicosButton = false;
  bool _ParentMateriasButton = false;

  Widget createParentLayoutRecomendados(Padre user) {
    final _controller = ScrollController();
    if (user.hijos.length > 1) {
      return _ParentRecomendadosButton
          ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                  height: 151.0,
                  width: SizeConfig.blockSizeHorizontal * 94,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "assets/images/explora-seleccion-grande.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: SizeConfig.blockSizeVertical * 2,
                  bottom: SizeConfig.blockSizeVertical * 2,
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Recomendados",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Nuestra selección \nexclusiva para vos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: "Sf-t",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 12,
                  left: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  bottom: 0,
                  right: 30,
                  left: 12,
                  child: Container(
                    child: FadingEdgeScrollView.fromScrollView(
                      child: ListView.builder(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: user.hijos.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index >= 1) {
                            String childName = user.hijos[index - 1].nombre;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GenericBookList.recomended(
                                      currentChild: user.hijos[index - 1],
                                    ),
                                  ),
                                );
                                setState(() {
                                  _ParentRecomendadosButton =
                                      !_ParentRecomendadosButton;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: SizeConfig.blockSizeHorizontal * 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        width: 62,
                                        height: 62,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                20, 255, 213, 104),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                    Text(
                                      childName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: "Sf-r",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 15,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  _ParentRecomendadosButton = !_ParentRecomendadosButton;
                });
                print('Click');
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                    height: 151.0,
                    width: SizeConfig.blockSizeHorizontal * 94,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/images/explora-seleccion-grande.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: SizeConfig.blockSizeVertical * 2,
                    bottom: SizeConfig.blockSizeVertical * 2,
                    width: SizeConfig.blockSizeHorizontal * 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Recomendados",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "Sf-r",
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nuestra selección \nexclusiva para vos",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: "Sf-t",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenericBookList.recomended(),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
              height: double.maxFinite,
              width: SizeConfig.blockSizeHorizontal * 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "assets/images/explora-seleccion-grande.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: SizeConfig.blockSizeVertical * 2,
              bottom: SizeConfig.blockSizeVertical * 2,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Recomendados",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Nuestra selección \nexclusiva para vos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "Sf-t",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
  Widget createParentLayoutEconomicos(Padre user) {
    final _controller = ScrollController();
    if (user.hijos.length > 1) {
      return _ParentEconomicosButton
          ? Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
            height: 151.0,
            width: SizeConfig.blockSizeHorizontal * 94,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/images/explora-economicos.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: SizeConfig.blockSizeVertical * 2,
            bottom: SizeConfig.blockSizeVertical * 2,
            width: SizeConfig.blockSizeHorizontal * 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Economicos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: "Sf-r",
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Selección de libros con los\n precios mas bajos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: "Sf-t",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 12,
            left: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.white.withOpacity(0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            bottom: 0,
            right: 30,
            left: 12,
            child: Container(
              child: FadingEdgeScrollView.fromScrollView(
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: user.hijos.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= 1) {
                      String childName = user.hijos[index - 1].nombre;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenericBookList.cheapest(
                                    currentChild: user.hijos[index - 1],
                                  ),
                            ),
                          );
                          setState(() {
                            _ParentEconomicosButton =
                            !_ParentEconomicosButton;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: 62,
                                  height: 62,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(
                                          20, 255, 213, 104),
                                      borderRadius:
                                      BorderRadius.circular(100)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              Text(
                                childName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: "Sf-r",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 15,
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      )
          : GestureDetector(
        onTap: () {
          setState(() {
            _ParentEconomicosButton = !_ParentEconomicosButton;
          });
          print('Click');
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
              height: 151.0,
              width: SizeConfig.blockSizeHorizontal * 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "assets/images/explora-economicos.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: SizeConfig.blockSizeVertical * 2,
              bottom: SizeConfig.blockSizeVertical * 2,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Economicos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Selección de libros con\nlos precios mas bajos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "Sf-t",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenericBookList.cheapest(),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
              height: double.maxFinite,
              width: SizeConfig.blockSizeHorizontal * 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "assets/images/explora-economicos.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: SizeConfig.blockSizeVertical * 2,
              bottom: SizeConfig.blockSizeVertical * 2,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Economicos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Selección de libros con\n los precios mas bajos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "Sf-t",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
  Widget createParentLayoutMaterias(Padre user) {
    final _controller = ScrollController();
    if (user.hijos.length > 1) {
      return _ParentMateriasButton
          ? Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 12, 5),
            height: 225,
            width: SizeConfig.blockSizeHorizontal * 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/images/explora-materias.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 15,
            width: SizeConfig.blockSizeHorizontal * 40,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Materias",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: "Sf-r",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Podrás elegir entre libros \nde materias especificas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: "Sf-t",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 12,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.white.withOpacity(0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            bottom: 0,
            right: 30,
            left: 12,
            child: Container(
              child: FadingEdgeScrollView.fromScrollView(
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: user.hijos.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= 1) {
                      String childName = user.hijos[index - 1].nombre;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenericBookList.cheapest(
                                    currentChild: user.hijos[index - 1]
                                  ),
                            ),
                          );
                          setState(() {
                            _ParentMateriasButton =
                            !_ParentMateriasButton;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical*4,
                              right: SizeConfig.blockSizeHorizontal * 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: 62,
                                  height: 62,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(
                                          20, 255, 213, 104),
                                      borderRadius:
                                      BorderRadius.circular(100)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              Text(
                                childName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: "Sf-r",
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 8,
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      )
          : GestureDetector(
        onTap: () {
          setState(() {
            _ParentMateriasButton = !_ParentMateriasButton;
          });
          print('Click');
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 12, 5),
              height: 225,
              width: SizeConfig.blockSizeHorizontal * 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "assets/images/explora-materias.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 15,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Materias",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Podrás elegir entre libros \nde materias especificas",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "Sf-t",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenericBookList.cheapest(),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
              height: double.maxFinite,
              width: SizeConfig.blockSizeHorizontal * 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "assets/images/explora-economicos.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: SizeConfig.blockSizeVertical * 2,
              bottom: SizeConfig.blockSizeVertical * 2,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Economicos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Selección de libros con\n los precios mas bajos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "Sf-t",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

/*class HomeTile extends StatefulWidget {
  final String title, description, backgroundImagePath;
  final User user;
  HomeTile(
      {Key key,
      this.title,
      this.description,
      this.backgroundImagePath,
      this.user,})
      : super(key: key){
    if(user!= null && user is Padre){
      userPadre = user;
    }
    if(user != null && user is AlumnoUniversitario){
      userUniversitario = user;
    }

  }
  Padre userPadre;
  AlumnoUniversitario userUniversitario;

 *//* @override
  _HomeTileState createState() => _HomeTileState();*//*//Arrange Update
}*/

/*class _HomeTileState extends State<HomeTile> {
  bool _ParentRecomendadosButton = false;
  final controllerMagico = ScrollController();

  @override
  Widget build(BuildContext context) {
    if ((widget.user is Padre && widget.userPadre.hijos.length > 1)
        || (widget.user is AlumnoUniversitario && widget.userUniversitario.universidades.length >1)) {
    return _ParentRecomendadosButton
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                height: 151.0,
                width: SizeConfig.blockSizeHorizontal * 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    widget.backgroundImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: SizeConfig.blockSizeVertical * 2,
                bottom: SizeConfig.blockSizeVertical * 2,
                width: SizeConfig.blockSizeHorizontal * 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w800,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.description,
//                  "Seleccion de libros con los mejores precios",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: "Sf-t",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 12,
                left: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Colors.white.withOpacity(0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                bottom: 0,
                right: 30,
                left: 12,
                child: Container(
                  child: FadingEdgeScrollView.fromScrollView(
                    child: ListView.builder(
                      controller: controllerMagico,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.userPadre.hijos.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= 1) {
                          String childName = widget.userPadre.hijos[index - 1].nombre;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _ParentRecomendadosButton =
                                !_ParentRecomendadosButton;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GenericBookList.recomended(
                                    currentChild: widget.userPadre.hijos[index - 1],
                                  ),
                                ),
                              );

                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      width: 62,
                                      height: 62,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(20, 255, 213, 104),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  Text(
                                    childName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 15,
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                _ParentRecomendadosButton = !_ParentRecomendadosButton;
              });
              print('Click');
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
                  height: 151.0,
                  width: SizeConfig.blockSizeHorizontal * 94,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      widget.backgroundImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: SizeConfig.blockSizeVertical * 2,
                  bottom: SizeConfig.blockSizeVertical * 2,
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Sf-r",
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontFamily: "Sf-t",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenericBookList.recomended(),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 5),
              height: double.maxFinite,
              width: SizeConfig.blockSizeHorizontal * 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  widget.backgroundImagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: SizeConfig.blockSizeVertical * 2,
              bottom: SizeConfig.blockSizeVertical * 2,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Sf-r",
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "Sf-t",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}*///Arrange Update
