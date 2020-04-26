import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/Models/school_model.dart';
import 'package:flutterui/Models/user_model.dart';
import 'package:flutterui/blocs/books_bloc/books_bloc.dart';
import 'package:flutterui/blocs/books_bloc/books_bloc_state.dart';
import 'package:flutterui/blocs/economicos_bloc/bloc.dart';
import 'package:flutterui/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:flutterui/blocs/favorites_bloc/favorites_bloc_event.dart';
import 'package:flutterui/blocs/favorites_bloc/favorites_bloc_state.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc.dart';
import 'package:flutterui/blocs/user_bloc/user_bloc_state.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:async/async.dart';

class CategoriesColegios extends StatefulWidget {
  CategoriesColegios({Key key}) : super(key: key);
  @override
  _CategoriesColegiosState createState() => _CategoriesColegiosState();
}

class _CategoriesColegiosState extends State<CategoriesColegios> {

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/economicos");
    BlocProvider.of<EconomicosBloc>(context).add(LoadUserEconomicosBooks());
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            height: SizeConfig.blockSizeVertical * 100,
          ),
          Positioned(
            left: 0,
            top: SizeConfig.blockSizeVertical * 6,
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
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
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
                    maxHeight: SizeConfig.blockSizeVertical * 94,
                    minHeight: SizeConfig.blockSizeVertical * 94,
                    color: Colors.transparent,
                    backdropEnabled: false,
                    backdropColor: AppColors.secondaryBackground,
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
                    child: BlocBuilder<UserBloc,UserBlocState>(
                      builder: (context,state){
                        if(state is UserLoadedState){
                          return CircleAvatar(
                            radius: 27.0,
                            backgroundImage: state.user.getProfileImage(),
                          );
                          /*Container(
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
                          )*/
                        }
                        return Container();

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*Positioned(
            top: SizeConfig.blockSizeVertical * 10,
            left: 28,
            child: Text(
              "Explorar",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
          ),*/
        ],
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
          left: 5,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios),
                iconSize: 26,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },),
              Container(
                width: SizeConfig.blockSizeHorizontal*50,
                child: Text(
                  'Materias',
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Sf-r',
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 60,
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
              child: seleccionCursos(sc),
            ),
          ),
        ),
      ],
    );
  }

  Widget seleccionColegios(ScrollController sc) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: sc,
        itemCount: schools.length,
        itemBuilder: (BuildContext context, int index) {
          School school = schools[index];
          return Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
            height: 94,
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color.withAlpha(100),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage(school.imageUrl),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      school.name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "13 libros subidos", //TODO cambiar esto por el class de Firebase
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                )
              ],
            ),
          );
        }); //TODO Agregar un if si el colegio esta seleccionado
  }

  Widget seleccionMaterias(ScrollController sc) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: sc,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
            height: 68,
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                SizedBox(width: 10),
                Container(
                  width: SizeConfig.blockSizeHorizontal*71,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(right: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(
                      child: Text(
                        "Materia nose cuanto por el amor de dios",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }); //TODO Agregar un if si el colegio esta seleccionado
  }

  Widget seleccionCursos(ScrollController sc) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: sc,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
            height: 68,
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                SizedBox(width: 10),
                Container(
                  width: SizeConfig.blockSizeHorizontal*71,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(right: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(
                      child: Text(
                        "Curso nose cuanto por el amor de dios",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }); //TODO Agregar un if si el colegio esta seleccionado
  }

  Widget listalibrosRecomendados(ScrollController sc) {
    SizeConfig().init(context);
    return BlocBuilder<BooksBloc,BooksBlocState>(
        builder: (context, state) {
          if(state is BooksLoadedState){
            return state.books!= null && state.books.length> 0?
            ListView.builder(
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
                                              style: Theme.of(context).primaryTextTheme.headline2,
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
                                              style: Theme.of(context).primaryTextTheme.headline3,
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
                                                        color: Theme.of(context).iconTheme.color,
                                                        onPressed: () {
                                                          BlocProvider.of<FavoritesBloc>(context).add(RemoveBookFromFavorites(book.uid));
                                                        });
                                                  }else{
                                                    return IconButton(
                                                        icon: Icon(Icons.favorite_border),
                                                        iconSize: 30.0,
                                                        color: Theme.of(context).iconTheme.color,
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
                                                color: Theme.of(context).hintColor,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                //todo sacar el boton de usado y cambiarlo por el de nuevo
                                                "USADO",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).primaryTextTheme.headline5,
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
                                                              style:Theme.of(context).primaryTextTheme.headline4,
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
                                                          style: Theme.of(context).textTheme.headline2,
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
            )
                :nadaQueMostrar(context);
          }
          return Center(child: CircularProgressIndicator(),);
        });
  }

  Widget listalibrosEconomicos(ScrollController sc) {
    SizeConfig().init(context);
    return BlocBuilder<EconomicosBloc,EconomicosBlocState>(
        builder: (context, state) {
          if (state is EconomicosBooksLoadedState) {
            return state.books!= null && state.books.length> 0?
            ListView.builder(
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
                                              style: Theme.of(context).primaryTextTheme.headline2,
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
                                              style: Theme.of(context).primaryTextTheme.headline3,
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
                                                        color: Theme.of(context).iconTheme.color,
                                                        onPressed: () {
                                                          BlocProvider.of<FavoritesBloc>(context).add(RemoveBookFromFavorites(book.uid));
                                                        });
                                                  }else{
                                                    return IconButton(
                                                        icon: Icon(Icons.favorite_border),
                                                        iconSize: 30.0,
                                                        color: Theme.of(context).iconTheme.color,
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
                                                color: Theme.of(context).hintColor,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                //todo sacar el boton de usado y cambiarlo por el de nuevo
                                                "USADO",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).primaryTextTheme.headline5,
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
                                                              style:Theme.of(context).primaryTextTheme.headline4,
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
                                                          style: Theme.of(context).textTheme.headline2,
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
            )
                :nadaQueMostrar(context);
          }
          return Center(child: CircularProgressIndicator(),);
        });
  }

  Widget listaAlumnos(ScrollController sc) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: sc,
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = users[index];

        return Container(
          margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
          height: 84,
          width: SizeConfig.blockSizeHorizontal * 100,
          /* decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 1.0,
                ),
              ]
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(user.imageUrl),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: TextStyle(
                          fontFamily: "Sf-r",
                          color: Color.fromARGB(255, 116, 116, 116),
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 21,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 116, 116, 116),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 235, 235, 235)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.star, size: 17, color: Colors.white),
                                Text(
                                  '${user.rating}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: "Sf-r",
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 21,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 235, 235, 235)),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  user.curso,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Sf-r",
                                    color: Color.fromARGB(130, 116, 116, 116),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(85, 15, 85, 0),
                height: 2,
                color: Colors.black12,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildEtiqueta(String url, String colegioName) {
    return UnconstrainedBox(
      child: Container(
        height: 32,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 22,
            width: 22,
            child: Image.asset(
              url,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            colegioName,
            style: TextStyle(
              fontFamily: "Sf-r",
              color: Color.fromARGB(255, 27, 27, 27),
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Icon(
                Icons.close,
                size: 22,
              ))
        ]),
      ),
    );
  }

  Widget nadaQueMostrar(context){
    return Container(
      child: Center(
          child: Text("Por el momento no pudimos encontrarte ninguna recomendacion.",style: TextStyle(
            fontSize: 26,
            fontFamily: 'Sf-r',
            color: Colors.black54,
            fontWeight: FontWeight.w700,

          ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
