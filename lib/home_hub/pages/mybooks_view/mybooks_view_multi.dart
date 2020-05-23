import 'dart:math';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/Models/user_model.dart';
import 'package:flutterui/Themes/AppStateNotifier.dart';
import 'package:flutterui/WidgetsCopy/Animated_screen.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/destacados_widget/destacados_section_dos.dart';
import 'package:flutterui/destacados_widget/economicos_section.dart';
import 'package:flutterui/dialogs/dialog_widget/custom_dialog.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/home_hub/admin_widgets.dart';
import 'package:flutterui/home_hub/generic_booklist_screen.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/pages/explore_view/categories/categories_colegios.dart';
import 'package:flutterui/home_hub/pages/home_view/home_view_dos.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/category_selector_multi.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/subir_foto_libro.dart';
import 'package:flutterui/home_hub/search_widget/search_widget.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/test/elije_un_rol_new.dart';
import 'package:flutterui/test/test1.dart';
import 'package:flutterui/test/test2.dart';
import 'package:flutterui/test/test_search.dart';
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

import 'catergory_selector.dart';

class MyBooksViewMulti extends StatefulWidget {
  HomeHubState homeHubState;
  MyBooksViewMulti({ this.homeHubState,Key key}) : super(key: key);
  @override
  MyBooksViewMultiState createState() => MyBooksViewMultiState();
}

class MyBooksViewMultiState extends State<MyBooksViewMulti> {
  PanelController _pc = new PanelController();
  HomeHubState myBooksState;

  List<Book>  publicados ;
  List<Book>  vendidos ;
  FirebaseAnalytics analytics;

  Widget gridView ;



  @override
  void initState() {
    analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/my_books");
    super.initState();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if(widget.homeHubState!= null){
      myBooksState = widget.homeHubState;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,

          ),
          onPressed: () {

            analytics.logEvent(name: "begins_subir_libro");
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
          Column(
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
                    body: _upperBody(context),
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
                    child: BlocBuilder<UserBloc, UserBlocState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
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

  Widget _upperBody(BuildContext context) {
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
                      child: Text(
                        "Mis libros",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Sf",
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      ),),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                  CategorySelectorMulti(this)
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
              IconButton(icon: Icon(Icons.search), iconSize: 26, color: Colors.white, onPressed:() {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchWidget(homeHubState: myBooksState),
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
              color: Theme.of(context).scaffoldBackgroundColor,
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
    );
  }

  Widget categoryScroll(BuildContext context) {
    return Container(
      height: 120,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 28),
          GestureDetector(
           onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*5),
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
    ListView(
      scrollDirection: Axis.vertical,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubirFotoLibro(),
              ),
            );
          },

          child:  Container(
            constraints: BoxConstraints.expand(height:SizeConfig.blockSizeVertical*45),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                  height: SizeConfig.blockSizeVertical*30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    child: Image.asset(
                      "assets/images/no-books.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )



        :CustomScrollView(
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
                                style: Theme.of(context).primaryTextTheme.headline3,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                "(${book.autor})",
                                style: Theme.of(context).primaryTextTheme.headline5,
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
                            builder: (context) => BookSection2(book),
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
            constraints: BoxConstraints.expand(height:SizeConfig.blockSizeVertical*45),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                  height: SizeConfig.blockSizeVertical*30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                    child: Image.asset(
                      "assets/images/no-ventas.png",
                      fit: BoxFit.fitWidth,
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
                color: Theme.of(context).cardColor,
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
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150.0,
            mainAxisSpacing: 10,
            crossAxisSpacing: 0,
            childAspectRatio: 0.53,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              Book book = books[index];

              return  Container(
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
                                style: Theme.of(context).primaryTextTheme.headline3,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                "(${book.autor})",
                                style: Theme.of(context).primaryTextTheme.headline5,
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
        ),
      ],
    );
  }
}
