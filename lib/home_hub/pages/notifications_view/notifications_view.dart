import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/chat_roles.dart';
import 'package:flutterui/Models/message_model.dart';
import 'package:flutterui/Themes/AppStateNotifier.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/home_hub/pages/notifications_view/category_selector_notification.dart';
import 'package:flutterui/home_hub/pages/notifications_view/chat_screen.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/size_config.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'chat_screen_buck.dart';

class NotificationView extends StatefulWidget {
  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  static Widget listViewVenta; //= ListViewVenta();
  static Widget listViewCompra; //= ListViewCompra();
  bool isVentaSelected = true;

  Widget listView = listViewVenta;

  @override
  void initState(){
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/notifications");
  }

  @override
  Widget build(BuildContext context) {
//    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context);
//    analytics.setCurrentScreen(screenName: "/home/notifications");
    BlocProvider.of<ChatsBloc>(context).add(LoadChats());
    return Scaffold(
      body:Container(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical * 12),
              Container(
                height: 31,
                margin: EdgeInsets.only(left: 28),
                child: Text(
                  "Mensajes",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Sf",
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),),
              SizedBox(height: 20),
              CategorySelectorNotification(this),
             Container(
               height: SizeConfig.blockSizeVertical* 70,
                 child: BlocBuilder<ChatsBloc, ChatsBlocState>(
                   builder: (context, state) {
                     if (state is ChatsLoaded) {
                       listViewVenta =
                           ListViewVenta(chats: state.chatsVentaList);
                       listViewCompra =
                           ListViewCompra(chats: state.chatsCompraList);
                       if (isVentaSelected) {
                         listView = listViewVenta;
                       } else {
                         listView = listViewCompra;
                       }
                       return Container(
                         margin: EdgeInsets.only(
                             top: SizeConfig.blockSizeVertical * 3),
                         child: listView,
                       );
                     }
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   },
                 )),

            ],
          ),
        ),
      ),

    );
  }

  // body: Stack(
  //   children: <Widget>[
  //     Positioned(
  //       top: SizeConfig.blockSizeVertical * 23,
  //       bottom: 0,
  //       left: 0,
  //       right: 0,
  //       child: Container(
  //           decoration: BoxDecoration(
  //           ),
  //           child: BlocBuilder<ChatsBloc, ChatsBlocState>(
  //             builder: (context, state) {
  //               if (state is ChatsLoaded) {
  //                 listViewVenta =
  //                     ListViewVenta(chats: state.chatsVentaList);
  //                 listViewCompra =
  //                     ListViewCompra(chats: state.chatsCompraList);
  //                 if (isVentaSelected) {
  //                   listView = listViewVenta;
  //                 } else {
  //                   listView = listViewCompra;
  //                 }
  //                 return Container(
  //                   margin: EdgeInsets.only(
  //                       top: SizeConfig.blockSizeVertical * 3),
  //                   child: listView,
  //                 );
  //               }
  //               return Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             },
  //           )),
  //     ),
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Stack(
  //           children: <Widget>[
  //             Positioned(
  //               top: SizeConfig.blockSizeVertical * 12,
  //               left: 28,
  //               child: Text(
  //                 "Mensajes",
  //                 style: Theme.of(context).accentTextTheme.headline1,
  //               ),
  //             ),
  //             Container(height: 143,decoration: BoxDecoration(color: Colors.transparent),),
  //           ],
  //         ), //Cartelito "Mis Libros"
  //         SizedBox(height: 20),
  //         CategorySelectorNotification(this),
  //       ],
  //     ),
  //   ],
  // ),
  Widget _upperBody(BuildContext context) {
    return Container(
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
                      "Mensajes",
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
                  CategorySelectorNotification(this),
                ],
              ),
            ),
          ],
        ),
      )
    ;
  }

  void changeFunction(int index) {
    if (index == 0) {
      setState(() {
        listView = listViewVenta;
        isVentaSelected = true;
      });
    } else {
      setState(() {
        listView = listViewCompra;
        isVentaSelected = false;
      });
    }
  }
}

class ListViewVenta extends StatelessWidget {
  final List<Chat> chats;

  const ListViewVenta({Key key, this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 10),
      padding: EdgeInsets.only(top: 10),
      child: chats == null || chats.length == 0
          ?  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height:SizeConfig.blockSizeVertical*60),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2, right: SizeConfig.blockSizeHorizontal*2),
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
                        Container(
                          width: SizeConfig.blockSizeHorizontal*70,
                          child: Text(
                            "Parece que no tienes chats activos",
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 57, 57),
                              fontSize: 17,
                              fontFamily: "Sf-r",
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: SizeConfig.blockSizeHorizontal*75,
                          child: Text(
                            "Solo te queda esperar que alguien te escriba por algún libro que tengas publicado para vender.",
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
                      "assets/images/no-chat-venta.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                final Chat chat = chats[index];
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<MessagesBloc>(context)
                        .add(LoadMessages(chat, ChatRole.VENDEDOR));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreenBuck(
                              chat: chat, chatRole: ChatRole.VENDEDOR),
                        ));
                  },

//                  Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (_) {
//                      BlocProvider.of<MessagesBloc>(context).add(LoadMessages(chat,ChatRole.VENDEDOR));
//                      return ChatScreenBuck(chat : chat,chatRole : ChatRole.VENDEDOR);}
//                  )),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: SizeConfig.blockSizeHorizontal * 13,
                        right: SizeConfig.blockSizeHorizontal * 3,
                        bottom: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: !chat.leidoPorElVendedor
                                ? AppColors.secondaryBackground
                                : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: !chat.leidoPorElVendedor
                                ? BorderRadius.all(Radius.circular(30))
                                : null,
                            // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal*100,
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 5,
                            right: SizeConfig.blockSizeHorizontal * 10,
                            top: 15,
                            bottom: 25),
                        //decoration: BoxDecoration(
                        // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: chat.compradorImage,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: SizeConfig.blockSizeHorizontal*43,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        chats[index].compradorNombre,
                                        style:  !chat.leidoPorElVendedor?  TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 29, 29, 29)
                                        ) :Theme.of(context).accentTextTheme.headline2,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.45,
                                        margin: EdgeInsets.only(top: 5, bottom: 5),
                                        child: chat.lastMessage != null
                                            ? Text(
                                                chat.lastMessage,
                                          style:  !chat.leidoPorElVendedor?  TextStyle(
                                            fontFamily: "Sf",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(255, 29, 29, 29)
                                          ) :Theme.of(context).accentTextTheme.headline3,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )
                                            : Container(),
                                      ),
                                      Text(
                                        chat.timestamp
                                                .toDate()
                                                .hour
                                                .toString() +
                                            ":" +
                                            (chat.timestamp.toDate().minute < 10
                                                ? '0${chat.timestamp.toDate().minute.toString()}'
                                                : chat.timestamp
                                                    .toDate()
                                                    .minute
                                                    .toString()),
                                        style: TextStyle(
                                          fontFamily: "Sf",
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 87, 87, 87),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                //TODO cambiar esto por un handler del estadoTransaccion
                                //si es true te permite aceptar o rechazar una compra
                                //si es false solo te permite hablarle al usuario
                                chat.estadoTransaccion == "Oferta"
                                    ? Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                  "RECHAAAAAZAAAAAAAAAAAAAAAAAR  COOOOOOOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMPRAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                                              showSlideDialogGrande(
                                                  context: context,
                                                  child: CustomDialog.customFunctions(
                                                    title: "Rechazar Solicitud De Compra",
                                                    description: "Al rechazar la compra le llegara al usuario una notificacion diciendo que le rechazaste la compra",
                                                    primaryButtonText: "CANCELAR",
                                                    secondaryButtonText: "Rechazar Compra",
                                                    primaryFunction: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    secondaryFunction: () {
                                                      BlocProvider.of<MessagesBloc>(context).add(RechazarSolicitudDeCompra(chat));
                                                      Navigator.of(context).pop();
                                                    },
                                                  ));
                                            },
                                            child: Container(
                                                height: 21,
                                                width: 21,
                                                child: Image.asset('assets/images/sell-icon2.png', color: !chat.leidoPorElVendedor? Color.fromARGB(255, 29, 29, 29) : Theme.of(context).iconTheme.color)),
                                          ),
                                          Container(
                                            height: 21,
                                            width: 2,
                                            color: Color.fromARGB(255, 57, 57, 57),
                                            margin: EdgeInsets.only(left: 10, right: 10),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                  "AAAAAACEEEEEEEEPTAAAAAAAAAAAAAAAAAR  COOOOOOOOOOOOOOOOOOOOOOOOOOOOOMMMMMMMMMMMMMMMMMPRAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                                              showSlideDialogGrande(
                                                  context: context,
                                                  child: CustomDialog.customFunctions(
                                                    title: "Aceptar Solicitud De Compra",
                                                    description: "Al Aceptar la compra se Rechazaran todas las otras ofertas de compra que tenias por este libro",
                                                    primaryButtonText: "CANCELAR",
                                                    secondaryButtonText: "Aceptar Compra",
                                                    primaryFunction: () {Navigator.of(context).pop();
                                                    },
                                                    secondaryFunction: () {
                                                      BlocProvider.of<MessagesBloc>(context).add(AceptarSolicitudDeCompra(chat));
                                                      Navigator.of(context).pop();
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (_) {
                                                        return ChatScreenBuck(
                                                            chat: chat,
                                                            chatRole: ChatRole.VENDEDOR);
                                                      }));
                                                    },
                                                  ));
                                            },
                                            child: Container(
                                                height: 21,
                                                width: 21,
                                                child: Image.asset(
                                                    'assets/images/sell-icon1.png', color: !chat.leidoPorElVendedor? Color.fromARGB(255, 29, 29, 29) : Theme.of(context).iconTheme.color)),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: <Widget>[
                                          Text(""),
                                          chat.leidoPorElVendedor
                                              ? Container(
                                                  child: Icon(
                                                    FontAwesome5.comment,
                                                    size: 21,
                                                    color: Theme.of(context).iconTheme.color,
                                                  ),
                                                )
                                              : Container(
                                                  child: Icon(
                                                    FontAwesome5Solid.comment,
                                                    size: 21,
                                                    color: Color.fromARGB(255, 29, 29, 29),
                                                  ),
                                                )
                                        ],
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 85,
                        right: 85,
                        child: Container(
                          height: 1,
                          width: 100,
                          color: Color.fromARGB(20, 57, 57, 57),
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}

class ListViewCompra extends StatelessWidget {
  final List<Chat> chats;

  const ListViewCompra({Key key, this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 10),
      padding: EdgeInsets.only(top: 10),
      child: chats == null || chats.length == 0
          ?  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height:SizeConfig.blockSizeVertical*60),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*2, right: SizeConfig.blockSizeHorizontal*2),
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
                        Container(
                          width: SizeConfig.blockSizeHorizontal*70,
                          child: Text(
                            "¿Todavía no has consultado por ningún libro?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 57, 57),
                              fontSize: 17,
                              fontFamily: "Sf-r",
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: SizeConfig.blockSizeHorizontal*75,
                          child: Text(
                            "Prueba explorar entre tus libros recomendados. Probablemente encuentres alguno que te interesa.",
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
                      "assets/images/no-chat-compra.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          :ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            final Chat chat = chats[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) {
                    BlocProvider.of<MessagesBloc>(context)
                        .add(LoadMessages(chat, ChatRole.COMPRADOR));
                    return ChatScreenBuck(
                        chat: chat, chatRole: ChatRole.COMPRADOR);
                  },
                ));
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: SizeConfig.blockSizeHorizontal * 13,
                    right: SizeConfig.blockSizeHorizontal * 3,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: !chat.leidoPorElComprador
                            ? AppColors.secondaryBackground
                            : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: !chat.leidoPorElComprador
                            ? BorderRadius.all(Radius.circular(30))
                            : null,
                        // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 10,
                        top: 15,
                        bottom: 25),
                    //decoration: BoxDecoration(
                    // borderRadius: chat.unread ?BorderRadius.only(bottomLeft: Radius.circular(30)):null,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(

                              radius: 30.0,
                              backgroundImage: chats[index].vendedorImage,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: SizeConfig.blockSizeHorizontal*43,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    chats[index].vendedorNombre,
                                    style:  !chat.leidoPorElComprador?  TextStyle(
                                        fontFamily: "Sf",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 29, 29, 29)
                                    ) :Theme.of(context).accentTextTheme.headline2,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: chat.lastMessage != null
                                        ? Text(
                                            chat.lastMessage,
                                            style:  !chat.leidoPorElComprador?  TextStyle(
                                                fontFamily: "Sf",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(255, 29, 29, 29)
                                            ) :Theme.of(context).accentTextTheme.headline3,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          )
                                        : Container(),
                                  ),
                                  Text(
                                    chat.timestamp.toDate().hour.toString() +
                                        ":" +
                                        (chat.timestamp.toDate().minute < 10
                                            ? '0${chat.timestamp.toDate().minute.toString()}'
                                            : chat.timestamp
                                                .toDate()
                                                .minute
                                                .toString()),
                                    style: TextStyle(
                                      fontFamily: "Sf",
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 87, 87, 87),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                chat.estadoTransaccion == "Pregunta"
                                    ? Container(
                                        child: Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                showSlideDialogGrande(
                                                    context: context,
                                                    child: CustomDialog.customFunctions(
                                                      title: "Enviar Solicitud De Compra",
                                                      description: "Una vez enviada la solicitud de compra esta no se podra cancelar",
                                                      primaryButtonText: "CANCELAR",
                                                      secondaryButtonText: "Solicitar Compra",
                                                      primaryFunction: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      secondaryFunction: () {
                                                        BlocProvider.of<MessagesBloc>(context).add(LoadMessages(chat, ChatRole.COMPRADOR));
                                                        BlocProvider.of<MessagesBloc>(context).add(SolicitarCompra(chat));
                                                        Navigator.pop(context);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                                  return ChatScreenBuck(
                                                                      chat: chat,
                                                                      chatRole: ChatRole.COMPRADOR);
                                                                }));
                                                      },
                                                    ));
                                              },
                                              child: Container(
                                                  height: 21,
                                                  width: 21,
                                                  child: Icon(Icons.add_shopping_cart, color: !chat.leidoPorElComprador? Color.fromARGB(255, 29, 29, 29) : Theme.of(context).iconTheme.color,)),
                                            ),
                                            Container(
                                              height: 21,
                                              width: 2,
                                              color: Color.fromARGB(255, 57, 57, 57),
                                              margin: EdgeInsets.only(left: 10, right: 10),
                                            ),
                                           /* IconButton(
                                              icon: Icon(
                                                MaterialIcons.shopping_basket,
                                                size: 21,
                                                color: Color.fromARGB(
                                                    255, 57, 57, 57),
                                              ),
                                              onPressed: () {
                                                showSlideDialogGrande(
                                                    context: context,
                                                    child: CustomDialog.customFunctions(
                                                      title: "Enviar Solicitud De Compra",
                                                      description: "Una vez enviada la solicitud de compra esta no se podra cancelar",
                                                      primaryButtonText: "CANCELAR",
                                                      secondaryButtonText: "Solicitar Compra",
                                                      primaryFunction: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      secondaryFunction: () {
                                                        BlocProvider.of<MessagesBloc>(context).add(LoadMessages(chat, ChatRole.COMPRADOR));
                                                        BlocProvider.of<MessagesBloc>(context).add(SolicitarCompra(chat));
                                                        Navigator.pop(context);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return ChatScreenBuck(
                                                              chat: chat,
                                                              chatRole: ChatRole.COMPRADOR);
                                                        }));
                                                      },
                                                    ));
                                              },
                                            ),
                                            Container(
                                              height: 21,
                                              width: 2,
                                              color: Color.fromARGB(255, 57, 57, 57),
                                              margin: EdgeInsets.only(left: 5, right: 5),
                                            )*/
                                          ],
                                        ),
                                      )
                                    : Text(""),
                                !chat.leidoPorElComprador
                                    ? Container(
                                        child: Icon(
                                          FontAwesome5Solid.comment,
                                          size: 21,
                                          color: Color.fromARGB(255, 57, 57, 57),
                                        ),
                                      )
                                    : Container(
                                        child: Icon(
                                          FontAwesome5.comment,
                                          size: 21,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                      )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  //todo acaaaaaaaaaaaaaaaaaaa esto es lo que hay que cambiar
                  Positioned(
                    top: 100,
                    left: 85,
                    right: 85,
                    child: Container(
                      height: 1,
                      width: 100,
                      color: Color.fromARGB(20, 57, 57, 57),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
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
