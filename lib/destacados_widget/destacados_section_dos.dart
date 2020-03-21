import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DestacadosSectionDos extends StatefulWidget {
  DestacadosSectionDos({Key key}) : super(key: key);
  @override
  _DestacadosSectionDosState createState() => _DestacadosSectionDosState();
}

class _DestacadosSectionDosState extends State<DestacadosSectionDos> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            height: SizeConfig.blockSizeVertical * 100,
          ),
          Positioned(
            left: 0,
            top: SizeConfig.blockSizeVertical * 5,
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
    return BlocBuilder<BooksBloc,BooksBlocState>(
    builder: (context, state) {
    if(state is BooksLoadedState){
      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 5,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios), iconSize: 26, color: Colors.white, onPressed:() {
                  Navigator.pop(context);
                },),
                Text(
                  'Recomendados',
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Sf-r',
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 55,
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
                    topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                child: ListView.builder(
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
                                                    ),
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
                              child:book.getFirstImageThumb() != null ? Image(
                                image : book.getFirstImageThumb(),
                                fit: BoxFit.cover,
                              )
                              :
                              CircularProgressIndicator(),
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
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Center(child: CircularProgressIndicator(),);
    });
  }
}
