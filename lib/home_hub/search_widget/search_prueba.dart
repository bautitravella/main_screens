import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/destacados_widget/destacados_section_dos.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/pages/explore_view/categories/categories_colegios.dart';
import 'package:flutterui/home_hub/pages/home_view/home_view_dos.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/test/test_search.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchWidgetPrueba extends StatefulWidget {
  HomeHubState homeHubState;
  SearchWidgetPrueba({this.homeHubState,Key key}) : super(key: key);

  @override
  _SearchWidgetPruebaState createState() => _SearchWidgetPruebaState();
}

class _SearchWidgetPruebaState extends State<SearchWidgetPrueba> {
  PanelController _pc = new PanelController();
  HomeHubState homeHubState;
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
  bool searchTextEmpty = true;
  FirebaseAnalytics analytics;
  List<Book> booksList = [];

  @override
  void initState (){homeHubState= widget.homeHubState;
    BlocProvider.of<IndexesBloc>(context).add(LoadIndexes());
  }

  Widget build(BuildContext context) {
    analytics = Provider.of<FirebaseAnalytics>(context);
    analytics.setCurrentScreen(screenName: "/home/search");
    SizeConfig().init(context);
    List<Book> booksList = [];

    /*  if (_keyboardIsVisible()){_pc.open();} else { _pc.close();}*/
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            height: SizeConfig.blockSizeVertical * 100,
            /*child: Stack(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 31,
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
            ),*/
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
                    controller: _pc,
                    /*body: Container(color: Colors.red,
                    constraints: BoxConstraints.expand(),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 8,
                              ),
                              categoryScroll,
                            ],
                          ),
                        ),
                      ],
                    ),),*/
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 85,
                    minHeight: _keyboardIsVisible()
                        ? SizeConfig.blockSizeVertical * 85
                        : SizeConfig.blockSizeVertical * 65,
                    color: Colors.white,
                    backdropEnabled: false,
                    backdropColor: AppColors.secondaryBackground,
                    body: _upperBody(),
                    parallaxEnabled: false,
                    parallaxOffset: 0.9,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Color.fromRGBO(0, 0, 0, 0.15),
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
        ],
      ),
    );
  }

  Widget _upperBody() {
    return FadeIn(
      child: Container(
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
              top: SizeConfig.blockSizeVertical * 7,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(right: 18, left: 18),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 211, 96),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                iconSize: 18,
                                color: Colors.white,
                                onPressed: () => Navigator.pop(context)),
                            /*Center(
                              child: Container(
                                height: 75,
                                color: Colors.red,
                                margin: EdgeInsets.only(left: 10, top: 30),
                                width: SizeConfig.blockSizeHorizontal * 62,
                                child: TextField(
                                  onChanged: (value) {
                                    analytics.logSearch(searchTerm: value);
                                    print(value);
                                    if(value == null || value.length == 0){
                                      searchTextEmpty = true;
                                    }else{
                                      searchTextEmpty = false;
                                      BlocProvider.of<SearchBloc>(context)
                                          .add(SearchBooks(value.toLowerCase().split(' ')));
                                    }
                                  },
                                  textCapitalization: TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
                                    hintText: "Buscar",
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sf-r",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),*/
                            Container(
                              height: 50,
                              width: SizeConfig.blockSizeHorizontal*63,
                              child: TextField(
                                onChanged: (value) {
                                  //analytics.logSearch(searchTerm: value);
                                  print(value);
                                  if(value == null || value.length == 0){
                                    searchTextEmpty = true;
                                  }else{
                                    searchTextEmpty = false;
                                    setState(() {
                                      booksList = BlocProvider.of<IndexesBloc>(context).indexManager.searchByName(value);
                                      print("SEARCH PRUEBAAA: "+ booksList.toString());
                                    });

                                  }
                                },
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.only(top: 15, bottom: 15),
                                  hintText: "Buscar",
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                    fontFamily: "Sf-r",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sf-r",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            icon: Icon(Icons.search),
                            iconSize: 25,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  categoryScroll(context),
                ],
              ),
            ),
            /*Positioned(
              top: 0,
              right: 0,
              child:  Container(
                height: 143,
                width: 143,
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
                        child: Container(
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
                              child: Image.asset(
                                "assets/images/avatar.png",
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
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
          top: 20,
          left: 25,
          right: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  _keyboardIsVisible()? "Resultados":'Recomendados',
                  style: TextStyle(
                    fontFamily: 'Sf-r',
                    fontSize: 17,
                    color: Color.fromARGB(255, 57, 57, 57),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: BlocBuilder<IndexesBloc,IndexesBlocState>(
                  builder: (context, state) {
                    if (searchTextEmpty) {
                      return BlocBuilder<BooksBloc,BooksBlocState>(
                        builder: (context, state) {
                          if(state is BooksLoadedState) {
                            if(state.books.length == 0){
                              return GestureDetector(
                                onTap: () {
                                  FocusScopeNode currentFocus = FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: <Widget>[
                                    Container(
                                      constraints: BoxConstraints.expand(height:SizeConfig.blockSizeVertical*60),
                                      margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                                      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2, right: SizeConfig.blockSizeHorizontal*2),
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
                                                  Container(
                                                    width: SizeConfig.blockSizeHorizontal*70,
                                                    child: Text(
                                                      "Arranca por buscar el nombre de tu libro",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(255, 57, 57, 57),
                                                        fontSize: 17,
                                                        fontFamily: "Sf-r",
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Container(
                                                    width: SizeConfig.blockSizeHorizontal*75,
                                                    child: Text(
                                                      "Se te mostraran los libros disponibles que concuerden con lo que escribas.",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(255, 57, 57, 57),
                                                        fontSize: 11,
                                                        fontFamily: "Sf-t",
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: SizeConfig.blockSizeVertical*10),
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal * 100,
                                            height: SizeConfig.blockSizeVertical*30,
                                            margin: EdgeInsets.only(left: 5, right: 5),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                              child: Image.asset(
                                                "assets/images/not-found.png",
                                                fit: BoxFit.fitHeight,
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
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: sc,
                              itemCount: state.books.length,
                              itemBuilder: (BuildContext context, int index) {
                                Book book = state.books[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookSection(book),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.fromLTRB(22, 13, 10, 0),
                                        height: 112,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child:book.getFirstImageThumb() != null ? Image(
                                            image : book.getFirstImageThumb(),
                                            fit: BoxFit.cover,
                                          )
                                              :
                                          CircularProgressIndicator(),
                                        ),
                                      ),
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 5, 12, 5),
                                            padding: EdgeInsets.fromLTRB(0, 13, 13, 11),
                                            height: 127.0,
                                            width: SizeConfig.blockSizeHorizontal * 68,
                                            decoration: BoxDecoration(
                                              /* color: Color.fromARGB(255, 241, 242, 242),*/
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                                              "${book.nombreLibro}",
                                                              style: TextStyle(
                                                                color: Color.fromARGB(200, 0, 0, 0),
                                                                fontSize: 15,
                                                                fontFamily: "Sf-r",
                                                                fontWeight: FontWeight.w700,
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
                                                              "${book.autor}",
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                fontFamily: "Sf",
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: <Widget>[
                                                          Align(
                                                            alignment: Alignment.topRight,
                                                            child:  BlocBuilder<FavoritesBloc,FavoritesBlocState>(
                                                              builder: (context,state){
                                                                if(state is FavoriteBooksLoaded){
                                                                  bool isFavorite = false;
                                                                  for(Book favBook in state.books){
                                                                    if(book.uid == favBook.uid)isFavorite = true;
                                                                  }
                                                                  if(isFavorite){
                                                                    //if(state.books.contains(book)){
                                                                    return IconButton(
                                                                        icon: Icon(Icons.favorite),
                                                                        iconSize: 30.0,
                                                                        color: Colors.black,
                                                                        onPressed: () {
                                                                          BlocProvider.of<FavoritesBloc>(context).add(RemoveBookFromFavorites(book.uid));
                                                                        });
                                                                  }else{
                                                                    return IconButton(
                                                                        icon: Icon(Icons.favorite_border),
                                                                        iconSize: 30.0,
                                                                        color: Colors.black,
                                                                        onPressed: () {
                                                                          BlocProvider.of<FavoritesBloc>(context).add(AddBookToFavorites(book.uid));

                                                                        });
                                                                  }
                                                                }
                                                                return IconButton(
                                                                    icon: Icon(Icons.favorite_border),
                                                                    iconSize: 30.0,
                                                                    color: Colors.black,
                                                                    onPressed: () {
                                                                      if (BlocProvider.of<FavoritesBloc>(context)
                                                                          .favoriteBooks !=
                                                                          null &&
                                                                          BlocProvider.of<FavoritesBloc>(context)
                                                                              .favoriteBooks
                                                                              .contains(book)) {
                                                                        BlocProvider.of<FavoritesBloc>(context)
                                                                            .add(RemoveBookFromFavorites(
                                                                            book.uid));
                                                                      } else {
                                                                        BlocProvider.of<FavoritesBloc>(context)
                                                                            .add(AddBookToFavorites(
                                                                            book.uid));
                                                                      }
                                                                    });
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: 15),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Container(
                                                              width: SizeConfig.blockSizeHorizontal * 14,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                color: Color.fromARGB(20, 0, 0, 0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              alignment: Alignment.center,
                                                              child: Text(
                                                                //todo sacar el boton de usado y cambiarlo por el de nuevo
                                                                "USADO",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight.w700,
                                                                  fontFamily: "Sf-r",
                                                                  color: Color.fromARGB(100, 0, 0, 0),
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          Container(
                                                            width: SizeConfig.blockSizeHorizontal * 62.5,
                                                            margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                Row(
                                                                  children: <Widget>[
                                                                    Container(
                                                                        height: 25,
                                                                        width: 25 ,
                                                                        child: CircleAvatar( backgroundImage: book.imageVendedor)
                                                                    ),
                                                                    book.rating != null?
                                                                    Container(
                                                                      height: 21,
                                                                      margin: EdgeInsets.only(left: 4),
                                                                      padding: EdgeInsets.only(left: 4, right: 4),
                                                                      decoration: BoxDecoration(
                                                                        color: Color.fromARGB(100, 116, 116, 116),
                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                        border: Border.all(
                                                                            width: 1.0, color: Color.fromARGB(255, 235, 235, 235)),
                                                                      ),
                                                                      alignment: Alignment.center,
                                                                      child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Icon(
                                                                              Icons.star,
                                                                              size: 17,
                                                                              color: Colors.white),
                                                                          Text(
                                                                            '${book.rating}',
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontFamily: "Sf-r",
                                                                                color: Colors.white
                                                                            ),
                                                                          ),

                                                                        ],
                                                                      ),
                                                                    ):
                                                                    Container(
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            SizedBox(width: 5,),
                                                                            Text(book.nombreVendedor.substring(0,1).toUpperCase() + "." + book.apellidoVendedor,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: "Sf-r",
                                                                                color: Color.fromARGB(
                                                                                    190, 0, 0, 0),
                                                                              ),
                                                                            )
                                                                          ],)),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                    const EdgeInsets.only(right: 5),
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Text(
                                                                          '\$${book.precio}',
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                            fontSize: 21,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontFamily: "Sf-r",
                                                                            color: Color.fromARGB(
                                                                                190, 0, 0, 0),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          /*Positioned(
                                left: SizeConfig.blockSizeHorizontal*6,
                                bottom: 15,
                                top: 15,
                                width: 75,
                                child:
                              ),*/
                                          Positioned(
                                              bottom: 0,
                                              left: 5,
                                              right: 22,
                                              child:Container(
                                                height: 2,
                                                color: Colors.black12,
                                              )
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                    } else{

                      if(booksList.length == 0){
                        return GestureDetector(
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints.expand(height:SizeConfig.blockSizeVertical*60),
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2, right: SizeConfig.blockSizeHorizontal*2),
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
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal*70,
                                              child: Text(
                                                "No hay ningún resultado para tu busqueda...",
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 57, 57, 57),
                                                  fontSize: 17,
                                                  fontFamily: "Sf-r",
                                                  fontWeight: FontWeight.w800,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal*75,
                                              child: Text(
                                                "Parece que no hay ningún libro con ese nombre.¡No te desanimes! Seguro hay muchos mas por encontrar. ",
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 57, 57, 57),
                                                  fontSize: 11,
                                                  fontFamily: "Sf-t",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: SizeConfig.blockSizeVertical*10),
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal * 100,
                                      height: SizeConfig.blockSizeVertical*30,
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                        child: Image.asset(
                                          "assets/images/not-found.png",
                                          fit: BoxFit.fitHeight,
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
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: sc,
                        itemCount: booksList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Book book = booksList[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookSection(book),
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(22, 13, 10, 0),
                                  height: 112,
                                  width: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child:book.getFirstImageThumb() != null ? Image(
                                      image : book.getFirstImageThumb(),
                                      fit: BoxFit.cover,
                                    )
                                        :
                                    CircularProgressIndicator(),
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 12, 5),
                                      padding: EdgeInsets.fromLTRB(0, 13, 13, 11),
                                      height: 127.0,
                                      width: SizeConfig.blockSizeHorizontal * 68,
                                      decoration: BoxDecoration(
                                        /* color: Color.fromARGB(255, 241, 242, 242),*/
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                                        "${book.nombreLibro}",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(200, 0, 0, 0),
                                                          fontSize: 15,
                                                          fontFamily: "Sf-r",
                                                          fontWeight: FontWeight.w700,
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
                                                        "${book.autor}",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily: "Sf",
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              left: 0,
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child:  BlocBuilder<FavoritesBloc,FavoritesBlocState>(
                                                        builder: (context,state){
                                                          if(state is FavoriteBooksLoaded){
                                                            bool isFavorite = false;
                                                            for(Book favBook in state.books){
                                                              if(book.uid == favBook.uid)isFavorite = true;
                                                            }
                                                            if(isFavorite){
                                                              //if(state.books.contains(book)){
                                                              return IconButton(
                                                                  icon: Icon(Icons.favorite),
                                                                  iconSize: 30.0,
                                                                  color: Colors.black,
                                                                  onPressed: () {
                                                                    BlocProvider.of<FavoritesBloc>(context).add(RemoveBookFromFavorites(book.uid));
                                                                  });
                                                            }else{
                                                              return IconButton(
                                                                  icon: Icon(Icons.favorite_border),
                                                                  iconSize: 30.0,
                                                                  color: Colors.black,
                                                                  onPressed: () {
                                                                    BlocProvider.of<FavoritesBloc>(context).add(AddBookToFavorites(book.uid));

                                                                  });
                                                            }
                                                          }
                                                          return IconButton(
                                                              icon: Icon(Icons.favorite_border),
                                                              iconSize: 30.0,
                                                              color: Colors.black,
                                                              onPressed: () {
                                                                if (BlocProvider.of<FavoritesBloc>(context)
                                                                    .favoriteBooks !=
                                                                    null &&
                                                                    BlocProvider.of<FavoritesBloc>(context)
                                                                        .favoriteBooks
                                                                        .contains(book)) {
                                                                  BlocProvider.of<FavoritesBloc>(context)
                                                                      .add(RemoveBookFromFavorites(
                                                                      book.uid));
                                                                } else {
                                                                  BlocProvider.of<FavoritesBloc>(context)
                                                                      .add(AddBookToFavorites(
                                                                      book.uid));
                                                                }
                                                              });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 15),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Container(
                                                        width: SizeConfig.blockSizeHorizontal * 14,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          color: Color.fromARGB(20, 0, 0, 0),
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          //todo sacar el boton de usado y cambiarlo por el de nuevo
                                                          "USADO",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w700,
                                                            fontFamily: "Sf-r",
                                                            color: Color.fromARGB(100, 0, 0, 0),
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Container(
                                                      width: SizeConfig.blockSizeHorizontal * 62.5,
                                                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Container(
                                                                  height: 25,
                                                                  width: 25 ,
                                                                  child: CircleAvatar( backgroundImage: book.imageVendedor)
                                                              ),
                                                              book.rating != null?
                                                              Container(
                                                                height: 21,
                                                                margin: EdgeInsets.only(left: 4),
                                                                padding: EdgeInsets.only(left: 4, right: 4),
                                                                decoration: BoxDecoration(
                                                                  color: Color.fromARGB(100, 116, 116, 116),
                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                  border: Border.all(
                                                                      width: 1.0, color: Color.fromARGB(255, 235, 235, 235)),
                                                                ),
                                                                alignment: Alignment.center,
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Icon(
                                                                        Icons.star,
                                                                        size: 17,
                                                                        color: Colors.white),
                                                                    Text(
                                                                      '${book.rating}',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w800,
                                                                          fontFamily: "Sf-r",
                                                                          color: Colors.white
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ):
                                                              Container(
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      SizedBox(width: 5,),
                                                                      Text(book.nombreVendedor.substring(0,1),
                                                                        style: TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.w700,
                                                                          fontFamily: "Sf-r",
                                                                          color: Color.fromARGB(
                                                                              190, 0, 0, 0),
                                                                        ),
                                                                      )
                                                                    ],)),
                                                            ],
                                                          ),
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets.only(right: 5),
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Text(
                                                                    '\$${book.precio}',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontSize: 21,
                                                                      fontWeight: FontWeight.w700,
                                                                      fontFamily: "Sf-r",
                                                                      color: Color.fromARGB(
                                                                          190, 0, 0, 0),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    /*Positioned(
                                left: SizeConfig.blockSizeHorizontal*6,
                                bottom: 15,
                                top: 15,
                                width: 75,
                                child:
                              ),*/
                                    Positioned(
                                        bottom: 0,
                                        left: 5,
                                        right: 22,
                                        child:Container(
                                          height: 2,
                                          color: Colors.black12,
                                        )
                                    )
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
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
                try {
                  Navigator.pop(context);
                  homeHubState?.changeToMyBooks();
                }catch(e){
                  print("SEARCH ERROR = " + e.toString());
                }
              });

//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => CategoriesColegios(),
//                ),
//              );
            },
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
          GestureDetector(
            onTap: (){
              try {
                Navigator.pop(context);
                homeHubState?.changeToFavorites();
              }catch(e){
                print("SEARCH ERROR = " + e.toString());
              }
            },
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
            onTap: (){
              try {
                Navigator.pop(context);
                homeHubState?.changeToChats();
              }catch(e){
                print("SEARCH ERROR = " + e.toString());
              }
            },
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
          /* GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Example9(),
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
                    "Search",
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
          ),*/
        ],
      ),
    );
  } //TODO especificarle cual de todas las categories
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
}