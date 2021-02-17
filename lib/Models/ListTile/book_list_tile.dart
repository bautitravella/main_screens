


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/book_section.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/test/test1.dart';

class BookTile extends StatelessWidget{

  Book book;

  BookTile(this.book);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookSection2(book),
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
                                    book.isNuevo?"NUEVO":"USADO",
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
                                            child: CircleAvatar( backgroundImage: book.getImageVendedor())
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
                                                Text(book.nombreVendedor != null?book.nombreVendedor.substring(0,1).toUpperCase() + "." + book.apellidoVendedor
                                                  :
                                                  " ",
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
                    color: Theme.of(context).iconTheme.color.withAlpha(10),
                  )
              )
            ],
          ),

        ],
      ),
    );

  }

}