import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/Message.dart';
import 'package:flutterui/Models/chat_roles.dart';
import 'package:flutterui/Models/user_model.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'package:flutterui/home_hub/pages/mybooks_view/vender/datos_libro.dart';
import 'package:flutterui/values/colors.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marquee/marquee.dart';

import '../../../size_config.dart';

class ChatScreenBuck extends StatefulWidget {
  final Chat chat;
  final ChatRole chatRole;
  ChatScreenBuck({@required this.chat, @required this.chatRole});

  @override
  _ChatScreenBuckState createState() => _ChatScreenBuckState();
}

class _ChatScreenBuckState extends State<ChatScreenBuck> {
  TextEditingController messageTextController = TextEditingController();

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Container(
            color: AppColors.secondaryBackground,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: SizeConfig.blockSizeVertical * 8,
                  right: 0,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      "assets/images/destacados-image.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 43,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 43,
                                child: Text(
                                  //TODO Rolling text
                                  widget.chatRole == ChatRole.COMPRADOR
                                      ? widget.chat.vendedorNombre
                                      : widget.chat.compradorNombre,
                                  style: TextStyle(
                                    fontFamily: "Sf-r",
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 43,
                          child: Text(
                            widget.chat.nombreLibro,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(150, 255, 255, 255),
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          _scrollingList(context),
          Container(
            height: 143,
            margin: EdgeInsets.only(left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        child: Stack(
                          children: <Widget>[
                            //Positioned(
                            //                    right: 0,
                            //                    top: 0,
                            //                    child: Align(
                            //                      alignment: Alignment.topRight,
                            //                      child: Container(
                            //                        width: 138,
                            //                        height: 143,
                            //                        child: Image.asset(
                            //                          "assets/images/round-underpic-shade.png",
                            //                          fit: BoxFit.fill,
                            //                        ),
                            //                      ),
                            //                    ),
                            //                  ),
                            Positioned(
                              child: CircleAvatar(
                                radius: 23.0,
                                backgroundImage:
                                widget.chatRole == ChatRole.COMPRADOR
                                    ? widget.chat.vendedorImage
                                    : widget.chat.compradorImage,
                              ),
                            ),
                            Positioned(
                              left: SizeConfig.blockSizeHorizontal * 8,
                              top: SizeConfig.blockSizeVertical * 4,
                              child: Container(
                                child: CircleAvatar(
                                  radius: 10.0,
                                  backgroundImage: AssetImage(
                                      "assets/images/logocolegio-fds.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollingList(BuildContext context) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    child: BlocBuilder<MessagesBloc, MessagesBlocState>(
                      builder: (context, state) {
                        if (state is MessagesLoaded) {
                          print(state.messages);
                          return ListView.builder(
                              reverse: true,
                              itemCount: state.messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Message message = state.messages[index];
                                bool isMe = true;
                                if (widget.chatRole == ChatRole.COMPRADOR) {
                                  if (message.email !=
                                      widget.chat.compradorEmail) {
                                    isMe = true;
                                  } else {
                                    isMe = false;
                                  }
                                } else {
                                  if (message.email !=
                                      widget.chat.vendedorEmail) {
                                    isMe = true;
                                  } else {
                                    isMe = false;
                                  }
                                }
                                //= message.sender.id == currentUser.id;
                                return _buildMessage(message, isMe);
                              });
                        } else if (state is MessagesLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is PotentialNewMessage) {
                          return Center(
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Text(
                                'Estas por consultar sobre el libro \n"${widget.chat.nombreLibro}"'
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontFamily: "Sf-r",
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else if (state is MessagesErrorLoading) {
                          showErrorDialog(context, state.errorMessage);
                          return Container();
                        }
                        return Center(child: CircularProgressIndicator());
//                          ListView.builder(
//                            reverse: true,
//                            itemCount: messages.length,
//                            itemBuilder: (BuildContext context, int index) {
//                              final Message message = messages[index];
//                              final bool isMe  = true;//= message.sender.id == currentUser.id;
//                              return _buildMessage(message, isMe);
//                            });
                      },
                    ),
                  )),
            ),
            widget.chat.estadoTransaccion == "Oferta" &&
                    widget.chatRole == ChatRole.VENDEDOR
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    height: 78,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("ACEPTAR"),
                          onPressed: () => showSlideDialogGrande(
                              context: context,
                              child: CustomDialog.customFunctions(
                                title: "Aceptar Solicitud De Compra",
                                description:
                                    "Al Aceptar la compra se Rechazaran todas las otras ofertas de compra que tenias por este libro",
                                primaryButtonText: "CANCELAR",
                                secondaryButtonText: "Aceptar Compra",
                                primaryFunction: () {
                                  Navigator.of(context).pop();
                                },
                                secondaryFunction: () {
                                  BlocProvider.of<MessagesBloc>(context).add(
                                      AceptarSolicitudDeCompra(widget.chat));
                                  setState(() {
                                    widget.chat.estadoTransaccion = "Vendido";
                                  });
                                  Navigator.of(context).pop();
                                },
                              )),
                        ),
                        RaisedButton(
                          child: Text("RECHAZAR"),
                          onPressed: () => showSlideDialogGrande(
                              context: context,
                              child: CustomDialog.customFunctions(title: "Rechazar Solicitud De Compra", description: "Al rechazar la compra le llegara al usuario una notificacion diciendo que le rechazaste la compra", primaryButtonText: "CANCELAR", secondaryButtonText: "Rechazar Compra",
                                primaryFunction:() {
                                  Navigator.of(context).pop();
                                },
                                secondaryFunction:() {
                                  BlocProvider.of<MessagesBloc>(context).add(RechazarSolicitudDeCompra(widget.chat));
                                  setState(() {
                                    widget.chat.estadoTransaccion = "Rechazada";
                                  });
                                  Navigator.of(context).pop();
                                },)),
                        ),
                      ],
                    ),
                  )
                : Container(),
            _buildMessageComposer()
          ],
        ),
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: isMe
                ? EdgeInsets.only(top: 15, bottom: 8, right: 14, left: 18)
                : EdgeInsets.only(top: 15, bottom: 8, left: 20, right: 20),
            margin: isMe
                ? EdgeInsets.only(top: 10, bottom: 10, right: 20)
                : EdgeInsets.only(top: 10, bottom: 10, left: 20),
            constraints: BoxConstraints(
              maxWidth: SizeConfig.blockSizeHorizontal * 70,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ? Color.fromARGB(255, 255, 205, 77)
                  : Color.fromARGB(255, 246, 248, 254),
              borderRadius: new BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.messageText,
                  style: isMe
                      ? TextStyle(
                          fontFamily: "Sf",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)
                      : TextStyle(
                          fontFamily: "Sf",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 96, 102, 115),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 0, right: 0),
                  child: Text(
                    message.sentTimestamp.toDate().hour.toString() +
                        ":" +
                        (message.sentTimestamp.toDate().minute < 10
                            ? '0${message.sentTimestamp.toDate().minute.toString()}'
                            : message.sentTimestamp.toDate().minute.toString()),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Sf",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isMe
                          ? Colors.white
                          : Color.fromARGB(255, 96, 102, 115),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 78,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 244, 244),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: messageTextController,
                        decoration: InputDecoration.collapsed(
                            hintText: "Di algo...",
                            hintStyle: TextStyle(
                              fontFamily: "Sf",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(100, 96, 102, 115),
                            )),
                      ),
                    ),
                  ),
                  /*Container(
                    width: 50,
                    margin: EdgeInsets.only(right: 10, top: 7, bottom: 7),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 203, 203, 203),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 25,
                        color: Color.fromARGB(255, 245, 244, 244),
                        onPressed: () {},
                      ),
                    ),
                  )*/ //TODO mandar fotos para proximo update
                ],
              ),
            ),
          ),
          _keyboardIsVisible()
              ? Container(
                  width: 65,
                  margin: EdgeInsets.fromLTRB(0, 10, 5, 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(180, 0, 191, 131),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Ionicons.ios_send),
                      iconSize: 25,
                      color: Colors.white,
                      onPressed: () {
                        Message message = Message.fromChatWidget(
                            messageTextController.text,
                            'text',
                            Timestamp.now());
                        messageTextController.clear();
                        BlocProvider.of<MessagesBloc>(context)
                            .add(AddMessage(message, widget.chatRole));
                      },
                    ),
                  ),
                )
              : Container(
                  width: 65,
                  margin: EdgeInsets.fromLTRB(0, 10, 5, 15),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    /*color: Color.fromARGB(255, 255, 104, 104),*/ //TODO implementar un state para compra solicitada o no
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      iconSize: 25,
                      color: Colors.white,
                      onPressed: () {
                        showCustomDialog(context);
                      },
                    ),
                    /* Container(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/images/cancel-order.png",
                      fit: BoxFit.fitHeight,),
                    )*/
                  ),
                ),
        ],
      ),
    );
  }
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
