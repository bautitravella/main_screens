import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/destacados_widget/destacados_section_dos.dart';
import 'package:flutterui/home_hub/pages/explore_view/categories/categories_colegios.dart';
import 'package:flutterui/home_hub/pages/home_view/home_view_dos.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/test/test_search.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key key}) : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  PanelController _pc = new PanelController();
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
  bool searchTextEmpty = true;

  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                            Center(
                              child: Container(
                                height: 24,
                                margin: EdgeInsets.only(left: 10, top: 23),
                                width: SizeConfig.blockSizeHorizontal * 60,
                                child: TextField(
                                  onChanged: (value) {
                                    print(value);
                                    if(value == null || value.length == 0){
                                      searchTextEmpty = true;
                                    }else{
                                      searchTextEmpty = false;
                                      BlocProvider.of<SearchBloc>(context)
                                          .add(SearchBooks(value.toLowerCase().split(' ')));
                                    }


                                  },
                                  decoration: InputDecoration(
                                    hintText: "Buscar",
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontFamily: "Sf-r",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Sf-r",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1, //TODO resolver tema del overflow
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
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
                  'Recomendados',
                  style: TextStyle(
                    fontFamily: 'Sf-r',
                    fontSize: 17,
                    color: Color.fromARGB(255, 57, 57, 57),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                height: 25,
                width: 98,
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: null,
                  disabledColor: Color.fromARGB(255, 255, 211, 96),
                  color: Color.fromARGB(255, 251, 187, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Text(
                    "VER TODO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
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
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: BlocBuilder<SearchBloc, SearchBlocState>(
                  builder: (context, state) {
                if (state is InitialSearchBlocState || searchTextEmpty) {
                  return BlocBuilder<BooksBloc,BooksBlocState>(
                    builder: (context, state) {
                      if(state is BooksLoadedState) {
                        if(state.books.length == 0){
                          return Text('No encontramos ningun resultado con esa descripcion');
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
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                                    padding: EdgeInsets.fromLTRB(13, 13, 13, 11),
                                    height: 127.0,
                                    width: SizeConfig.blockSizeHorizontal * 100,
                                    decoration: BoxDecoration(
                                      /* color: Color.fromARGB(255, 241, 242, 242),*/
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
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
                                                          if(state.books.contains(book)){
                                                            return IconButton(
                                                                icon: Icon(Icons.favorite),
                                                                iconSize: 30.0,
                                                                color: Colors.black,
                                                                onPressed: () {

                                                                  BlocProvider.of<FavoritesBloc>(context)
                                                                      .add(RemoveBookFromFavorites(
                                                                      book.uid));

                                                                });
                                                          }else{
                                                            return IconButton(
                                                                icon: Icon(Icons.favorite_border),
                                                                iconSize: 30.0,
                                                                color: Colors.black,
                                                                onPressed: () {

                                                                  BlocProvider.of<FavoritesBloc>(context)
                                                                      .add(AddBookToFavorites(
                                                                      book.uid));

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
                                                                    Text(book.nombreVendedor.substring(0,1) + "." + book.apellidoVendedor,
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
                                  Positioned(
                                    left: SizeConfig.blockSizeHorizontal*6,
                                    bottom: 15,
                                    top: 15,
                                    width: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        image : book.getFirstImageThumb(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: SizeConfig.blockSizeHorizontal*30,
                                      right: 22,
                                      child:Container(
                                        height: 2,
                                        color: Colors.black12,
                                      )
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state is SearchBooksLoaded) {
                  if(state.booksList.length == 0){
                    return Container(child: Center(child: Text('No Pudimos encontrar ningun resultado para lo que nos estas pidiendo'),),);
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: sc,
                    itemCount: state.booksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Book book = state.booksList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookSection(book),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                              padding: EdgeInsets.fromLTRB(13, 13, 13, 11),
                              height: 127.0,
                              width: SizeConfig.blockSizeHorizontal * 100,
                              decoration: BoxDecoration(
                                /* color: Color.fromARGB(255, 241, 242, 242),*/
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
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
                                                    if(state.books.contains(book)){
                                                      return IconButton(
                                                          icon: Icon(Icons.favorite),
                                                          iconSize: 30.0,
                                                          color: Colors.black,
                                                          onPressed: () {

                                                            BlocProvider.of<FavoritesBloc>(context)
                                                                .add(RemoveBookFromFavorites(
                                                                book.uid));

                                                          });
                                                    }else{
                                                      return IconButton(
                                                          icon: Icon(Icons.favorite_border),
                                                          iconSize: 30.0,
                                                          color: Colors.black,
                                                          onPressed: () {

                                                            BlocProvider.of<FavoritesBloc>(context)
                                                                .add(AddBookToFavorites(
                                                                book.uid));

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
                                                              Text(book.nombreVendedor.substring(0,1) + "." + book.apellidoVendedor,
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
                            Positioned(
                              left: SizeConfig.blockSizeHorizontal*6,
                              bottom: 15,
                              top: 15,
                              width: 75,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  image : book.getFirstImageThumb(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: SizeConfig.blockSizeHorizontal*30,
                                right: 22,
                                child:Container(
                                  height: 2,
                                  color: Colors.black12,
                                )
                            )
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
      width: SizeConfig.blockSizeHorizontal * 92,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesColegios(),
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
                        MaterialIcons.school,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Colegios",
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
          Container(
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
                      Icons.class_,
                      color: Colors.white,
                      size: 30,
                    )),
                Text(
                  "Materias",
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
          Container(
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
                      Icons.group,
                      color: Colors.white,
                      size: 30,
                    )),
                Text(
                  "Cursos",
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
          Container(
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
                      FontAwesome5.address_book,
                      color: Colors.white,
                      size: 30,
                    )),
                Text(
                  "Usuarios",
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeViewDos(),
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
                    "HomeView2",
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
          ),
        ],
      ),
    );
  } //TODO especificarle cual de todas las categories
}
