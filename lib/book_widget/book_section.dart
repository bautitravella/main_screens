import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/Models/books_model.dart';
import 'package:flutterui/Models/chat_roles.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/edit_book.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/home_hub/home_hub.dart';

import 'package:flutterui/home_hub/pages/mybooks_view/vender/datos_libro.dart';
import 'package:flutterui/home_hub/pages/notifications_view/chat_screen_buck.dart';
import 'package:flutterui/perfiles_widgets/perfil_alguien.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'book_section_chota.dart';
import 'package:photo_view/photo_view.dart';

class BookSection extends StatefulWidget {

  Book book;

  BookSection(this.book);

  @override
  _BookSectionState createState() => _BookSectionState();
}

class _BookSectionState extends State<BookSection> {

  bool isMyBook = false;

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/book_section");
    super.initState();
    if(widget.book.uid != null){
      BlocProvider.of<IndividualDocumentsBloc>(context).add(GetBook(widget.book.uid));
      BlocProvider.of<SimilarBooksBloc>(context).add(GetSimilarBooks(widget.book));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<UserBloc,UserBlocState>(
      builder: (context,state) {
        if(state is UserLoadedState) {
          String userEmail = state.user.email;
          if(userEmail == widget.book.emailVendedor){
            isMyBook = true;
          } else{
            isMyBook = false;
          }
          return BlocBuilder<IndividualDocumentsBloc,IndividualDocumentsBlocState>(
            builder: (context,state){
              if(state is BookDownloadedState){
                widget.book = state.book;
              }
              return Scaffold(
                body: Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: SizeConfig.blockSizeVertical * 23,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: verticalListView(widget.book),
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: SizeConfig.blockSizeVertical * 34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: Container(
                                    height: SizeConfig.blockSizeVertical * 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          iconSize: 30.0,
                                          color: Colors.black,
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Text(
                                            "LIBROS",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              color: AppColors.accentText,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    isMyBook?Row(
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.edit),
                                            iconSize: 30.0,
                                            color: Colors.black,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  //TODO cambiar el DatosLibro por una pagina que sea posta para editar un libro
                                                  builder: (context) => EditBookWidget(widget.book),
                                                ),
                                              );
                                            }
                                        ),
                                        /* Container(
                                        color: Colors.black26,
                                        height: 25,
                                        width: 2,
                                      ),*/
                                        //TODO para update
                                      ],
                                    ):
                                    Row(
                                      children: <Widget>[
                                        BlocBuilder<
                                            FavoritesBloc,
                                            FavoritesBlocState>(
                                          builder: (context, state) {
                                            if (state is FavoriteBooksLoaded) {
                                              bool isFavorite = false;
                                              for(Book favBook in state.books){
                                                if(widget.book.uid == favBook.uid)isFavorite = true;
                                              }
                                              if (isFavorite) {
                                                return IconButton(
                                                    icon: Icon(Icons.favorite),
                                                    iconSize: 30.0,
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                          FavoritesBloc>(context)
                                                          .add(
                                                          RemoveBookFromFavorites(
                                                              widget.book.uid));
                                                    });
                                              } else {
                                                return IconButton(
                                                    icon: Icon(
                                                        Icons.favorite_border),
                                                    iconSize: 30.0,
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                          FavoritesBloc>(context)
                                                          .add(AddBookToFavorites(
                                                          widget.book.uid));
                                                    });
                                              }
                                            }
                                            return IconButton(
                                                icon: Icon(Icons.favorite_border),
                                                iconSize: 30.0,
                                                color: Colors.black,
                                                onPressed: () {
                                                  if (BlocProvider
                                                      .of<FavoritesBloc>(context)
                                                      .favoriteBooks !=
                                                      null &&
                                                      BlocProvider
                                                          .of<FavoritesBloc>(
                                                          context)
                                                          .favoriteBooks
                                                          .contains(widget.book)) {
                                                    BlocProvider.of<FavoritesBloc>(
                                                        context)
                                                        .add(
                                                        RemoveBookFromFavorites(
                                                            widget.book.uid));
                                                  } else {
                                                    BlocProvider.of<FavoritesBloc>(
                                                        context)
                                                        .add(AddBookToFavorites(
                                                        widget.book.uid));
                                                  }
                                                });
                                          },
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal * 80,
                                      height: SizeConfig.blockSizeVertical * 10,
                                      margin: EdgeInsets.only(left: 22, top: 130),
                                      child: Text(
                                        widget.book.nombreLibro != null?widget.book.nombreLibro:
                                        " ", //widget.book.name,
                                        style: TextStyle(
                                          fontFamily: "Gibson",
                                          color: AppColors.accentText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal * 80,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      margin: EdgeInsets.only(left: 22, top: 5),
                                      child: Text(
                                        widget.book.autor != null? widget.book.autor: " ",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: AppColors.accentText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        left: 22,
                        right: 22,
                        bottom: 15,
                        height: 53,
                        child: Container(
                          child: isMyBook? Container(): Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        )
                                      ]),
                                  child: FlatButton(
                                      color: AppColors.secondaryElement,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                      ),
                                      textColor: Color.fromARGB(255, 255, 255, 255),
                                      padding: EdgeInsets.all(0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          Container(
                                            width: 2,
                                            height: 25,
                                            color: Colors.white,
                                            margin: EdgeInsets.only(
                                                left: 10, right: 10),
                                          ),
                                          Text(
                                            '\$${widget.book.precio}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.secondaryText,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        showSlideDialogGrande(
                                            context: context,
                                            child: CustomDialog.customFunctions(
                                              title: "Enviar Solicitud De Compra",
                                              description:
                                              "Una vez enviada la solicitud de compra esta no se podra cancelar",
                                              primaryButtonText: "CANCELAR",
                                              secondaryButtonText: "Solicitar Compra",
                                              primaryFunction: () {
                                                Navigator.of(context).pop();
                                              },
                                              secondaryFunction: () {
                                                Chat chat = Chat.fromBook(
                                                    widget.book);
                                                chat.estadoTransaccion = "Oferta";
                                                BlocProvider.of<ChatsBloc>(context)
                                                    .add(
                                                    AddChat(
                                                        chat, function: (newChat) {
                                                      BlocProvider.of<MessagesBloc>(
                                                          context)
                                                          .add(LoadMessages(
                                                          newChat,
                                                          ChatRole.COMPRADOR));
                                                    }));
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreenBuck(
                                                              chat: chat,
                                                              chatRole:
                                                              ChatRole.COMPRADOR,
                                                            )));
                                              },
                                            ));
                                      }),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0,
                                        )
                                      ]),
                                  child: FlatButton(
                                      color: Colors.black54,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                      ),
                                      textColor: Color.fromARGB(255, 255, 255, 255),
                                      padding: EdgeInsets.all(0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.chat_bubble,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Chat chat = Chat.fromBook(widget.book);
                                        chat.estadoTransaccion = "Pregunta";
                                        BlocProvider.of<MessagesBloc>(context)
                                            .add(
                                            LoadMessages(chat, ChatRole.COMPRADOR));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreenBuck(
                                                        chat: chat,
                                                        chatRole: ChatRole
                                                            .COMPRADOR)));
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },

          );
        }
        return CircularProgressIndicator();
        },

    );
  }

  Widget verticalListView(Book book) {
    return Container(
      height: SizeConfig.blockSizeVertical * 100,
      margin: EdgeInsets.all(0),
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      horizontalPhotos(book),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 22, left: 22, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Hero(
                                tag: 'profile',
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: book.imageVendedor)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    book.nombreVendedor != null && book.apellidoVendedor!= null?'${book.nombreVendedor + " " + book.apellidoVendedor}':
                                    book.nombreVendedorAcortado!= null?book.nombreVendedorAcortado:" ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 57, 57, 57),
                                    ),
                                  ),
                                  book.rating != null
                                      ? Row(
                                          children: <Widget>[
                                            Text(
                                              '${book.rating}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Montserrat",
                                                color: Color.fromARGB(
                                                    255, 118, 118, 118),
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 17,
                                              color: Color.fromARGB(
                                                  255, 118, 118, 118),
                                            ),
                                          ],
                                        )
                                      : Text(' '),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 245, 245),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    textColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      'USADO',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Montserrat",
                                        color:
                                            Color.fromARGB(255, 149, 149, 149),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Descripción",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(255, 57, 57, 57),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  child: Text(
                                    book.descripcion!= null? book.descripcion: " ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  child: Text(
                                    "Destalles",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Autor:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 5),
                                  width: SizeConfig.blockSizeHorizontal * 70,
                                  child: Text(
                                    book.autor != null? book.autor: " ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Color.fromARGB(255, 118, 118, 118),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            book.editorial != null
                                ? Row(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Text(
                                          "Editorial:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 0, left: 5),
                                        width:
                                            SizeConfig.blockSizeHorizontal * 70,
                                        child: Text(
                                          book.editorial,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                            book.isbn != null
                                ? Row(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Text(
                                          "ISBN:",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 5),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  70,
                                          child: Text(
                                            '${book.isbn}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              color: Color.fromARGB(
                                                  255, 118, 118, 118),
                                            ),
                                          )),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
//                 /* Row(
//                    children: <Widget>[
//                      Container(
//                        height: 55,
//                        width: SizeConfig.blockSizeHorizontal * 100,
//                        padding:
//                            const EdgeInsets.only(right: 80, left: 80, top: 30),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10.0),
//                        ),
//                        child: FlatButton(
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.all(Radius.circular(24)),
//                          ),
//                          textColor: Color.fromARGB(255, 255, 255, 255),
//                          padding: EdgeInsets.all(0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              Icon(
//                                Icons.share,
//                                color: Color.fromARGB(180, 118, 118, 118),
//                                size: 25,
//                              ),
//                              Text(
//                                "Compartir".toUpperCase(),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontSize: 21,
//                                  fontWeight: FontWeight.w600,
//                                  fontFamily: "Montserrat",
//                                  color: Color.fromARGB(180, 118, 118, 118),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
                  BlocBuilder<SimilarBooksBloc,SimilarBooksBlocState>(builder: (BuildContext context, state) {
                    if(state is SimilarBooksDownloadedState && state.booksList != null && state.booksList.length != 0){
                      return Container(
                        child: Column(
                          children: [
                            Container(
                                height: 55,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 15),
                                padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 21),
                                      child: Text(
                                        "LIBROS SIMILARES",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 57, 57, 57),
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 98,
                                      alignment: Alignment.centerRight,
                                      child: FlatButton(
                                        onPressed: null,
                                        disabledColor: AppColors.secondaryBackground,
                                        color: Color.fromARGB(255, 251, 187, 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => HomeHub()));
                                          },
                                          child: Text(
                                            "VER TODO",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            horizontalListView(state.booksList),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },

                  ),

                  //horizontalListView,
//                  Container(
//                      height: 55,
//                      alignment: Alignment.center,
//                      padding:
//                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Container(
//                            margin: EdgeInsets.only(left: 21),
//                            child: Text(
//                              "PARA VOS",
//                              textAlign: TextAlign.left,
//                              style: TextStyle(
//                                color: Color.fromARGB(255, 57, 57, 57),
//                                fontFamily: "Montserrat",
//                                fontWeight: FontWeight.w700,
//                                fontSize: 15,
//                              ),
//                            ),
//                          ),
//                          Container(
//                            height: 50,
//                            width: 98,
//                            alignment: Alignment.centerRight,
//                            child: FlatButton(
//                              onPressed: null,
//                              disabledColor: AppColors.secondaryBackground,
//                              color: Color.fromARGB(255, 251, 187, 16),
//                              shape: RoundedRectangleBorder(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(14)),
//                              ),
//                              child: GestureDetector(
//                                onTap: () {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => HomeHub()));
//                                },
//                                child: Text(
//                                  "VER TODO",
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    color: Color.fromARGB(255, 255, 255, 255),
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 13,
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      )),
//                  horizontalListView, //TODO Para agregar en un futuro
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget horizontalPhotos(Book book) {
    return Container(
      height: 185,
      margin: EdgeInsets.only(left: 22, top: 60),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: book.getImages().length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 180,
            width: 123,
            margin: EdgeInsets.only(right: 35),
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              onTap: (){
                open(context, index,book);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: book.getImages() != null && book.getImages().length > 0? //book.images[0],
                  Image(
                    image: book.getImages()[index],
                    fit: BoxFit.cover,
                  )
                      :
                  CircularProgressIndicator(),

                  ),
            ),
          );
        },
      ),
    );
  }

  void open(BuildContext context, final int index,Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: book.getImages(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection:  Axis.horizontal,
        ),
      ),
    );
  }


}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<ImageProvider> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ImageProvider item = widget.galleryItems[index];
    return  PhotoViewGalleryPageOptions(
      imageProvider: item,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
    );
  }
}


Widget horizontalListView(List<Book> booksList){
  return Container(
    height: 240,
    margin: EdgeInsets.only(left: 22),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: booksList.length,
      itemBuilder: (BuildContext context, int index) {
        Book book = booksList[index];

        return Container(
          margin: EdgeInsets.all(7.0),
          width: 97,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: Container(
                  height: 80,
                  width: 97,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          book.nombreLibro!=null?"${book.nombreLibro}":" ",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          book.autor!= null?"(${book.autor})": " ",
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
                      builder: (context) => BookSection(book),
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
    ),
  );
}



showCustomDialog(BuildContext context) {
  showSlideDialogGrande(
      context: context,
      child: CustomDialog.customFunctions(
        title: "Que elegis?",
        description: "Que deseas elegir",
        primaryButtonText: "LoadingDialog",
        secondaryButtonText: "ErrorDialog",
        primaryFunction: () {
          print(
              "SHOW LOAAAAAAAAAAAAAAAAAAAAAADIIIIIINNNNNNGGGGGGGG..................");
          showLoadingDialog(context);
        },
        secondaryFunction: () {
          print(
              "SHOW ERRRRRRRRROOOOOOOOOOOOOOOOOOOORRRRRRRRRRRRRRRRR..................");
          showErrorDialog(context, "TODO MAL");
        },
      ));
//  Center(child: Column(children: [
//    RaisedButton(
//      child: Text("showLoadingDialog"),
//      onPressed: () => showLoadingDialog(context),
//    )
//  ]))
}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: LoadingDialog(),
      animatedPill: true,
      barrierDismissible: false);
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showSlideDialogChico(
      context: context,
      child: ErrorDialog(
        title: "Oops...",
        error: errorMessage,
      ),
      animatedPill: false);
}
