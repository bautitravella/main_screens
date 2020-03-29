import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Chat.dart';
import 'package:flutterui/Models/EstadoMessage.dart';
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
  Chat chat;
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
    return WillPopScope(
      onWillPop: ()=>_onWillPop(context),
      child: Scaffold(
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
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () => _onWillPop(context),
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
                  //TODO volver a agregar los puntitos pero esta vez agregarle funcionalidades
//                Container(
//                  margin: EdgeInsets.only(right: 20),
//                  child: IconButton(
//                    icon: Icon(
//                      Icons.more_horiz,
//                      size: 30,
//                      color: Color.fromARGB(255, 255, 255, 255),
//                    ),
//                    onPressed: () => Navigator.pop(context),
//                  ),
//                ),
                ],
              ),
            ),
          ],
        ),
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
                          if(widget.chat.publicacionId == state.chat.publicacionId
                          && widget.chat.vendedorEmail == state.chat.vendedorEmail){
                            widget.chat = state.chat;
                          }
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
                          //showErrorDialog(context, state.errorMessage);
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
    BlocBuilder<MessagesBloc, MessagesBlocState>(
    builder: (context, state) {
    if (state is MessagesLoaded) {
      return state.chat.estadoTransaccion == "Oferta" &&
          widget.chatRole == ChatRole.VENDEDOR
          ? Container(
        height: 155,

        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 120,
                width: 64,
                padding: EdgeInsets.only(top: 28, bottom: 28, right: 28),
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                        200, 0, 191, 131),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(64), topRight: Radius.circular(64))
                ),
                child: Image.asset("assets/images/accept-icon.png",fit: BoxFit.fill,),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( "${widget.chat.compradorNombre}",
                  style: TextStyle(
                      fontFamily: "Sf-r",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 118, 118, 118)),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  "a solicitado la compra de \n${widget.chat.nombreLibro},\n¡No la hagas esperar!",
                  style: TextStyle(
                      fontFamily: "Sf-r",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 118, 118, 118)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Color.fromARGB(
                          200, 0, 191, 131),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        "Vender",
                        style: TextStyle(
                            fontFamily: "Sf-r",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
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
                    SizedBox(width: 15,),
                    FlatButton(
                      color: Color.fromARGB(
                          255, 255, 104, 104),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        "Rechazar",
                        style: TextStyle(
                            fontFamily: "Sf-r",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
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
              ],
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 120,
                width: 64,
                padding: EdgeInsets.only(top: 28, bottom: 28, left: 28),
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                        255, 255, 104, 104),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64), topLeft: Radius.circular(64))
                ),
                child: Image.asset("assets/images/decline-icon.png",fit: BoxFit.fill,),
              ),
            ),
          ],
        ),
      )
          : Container();
    }
    return Container();
    }),

            _buildMessageComposer()
          ],
        ),
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    if(message is EstadoMessage){
      String estado = message.estado;
      String mensajeText = "TRAVE lo que quieras0";

      if(estado == "Pregunta")mensajeText = isMe?"HAS INICIADO UNA CONSULTA":"HAN INICIADO UNA CONSULTA";
      else if(estado == "Oferta")mensajeText = isMe?"HAS SOLICITADO UNA COMPRA":"HAN SOLICITADO UNA COMPRA";
      else if(estado == "Vendido")mensajeText = isMe?"HAS VENDIDO EL LIBRO":"HAS COMPRADO EL LIBRO";
      else if(estado == "Rechazada") mensajeText = isMe?"HAS RECHAZADO LA OFERTA":"TE HAN RECHAZADO LA OFERTA";
      else if(estado == "Cancelada") mensajeText = isMe?"HAS CANCELADO LA OFERTA":"HAN CANCELADO LA OFERTA";

      return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                padding: EdgeInsets.only(top: 7, bottom: 7, right: 0, left: 0),
                margin: EdgeInsets.only(top: 20, bottom: 20, left: SizeConfig.blockSizeHorizontal * 15, right: SizeConfig.blockSizeHorizontal * 15),
                constraints: BoxConstraints(
                  maxWidth: SizeConfig.blockSizeHorizontal * 70,
                ),
                decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 219, 219, 219),
                  borderRadius: new BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      mensajeText,
                      style:  TextStyle(
                          fontFamily: "Sf",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5),
                    Container(
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
                          color:Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          /*Container(
              padding:  EdgeInsets.only(top: 15, bottom: 8, left: 10, right: 10),
              margin:EdgeInsets.only(top: 10, bottom: 10, right: 5,left: 5),

              constraints: BoxConstraints(
                maxWidth: SizeConfig.blockSizeHorizontal * 70,
              ),
              decoration: BoxDecoration(
                color:  Colors.grey,
                borderRadius: new BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.estado,
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
                            ? Colors.greenAccent
                            : Color.fromARGB(255, 96, 102, 115),
                      ),
                    ),
                  )
                ],
              )),*/
        ],
      );
    }
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
          BlocBuilder<MessagesBloc, MessagesBlocState>(
          builder: (context, state) {
              if (state is MessagesLoaded) {
              print(state.messages);
              widget.chat = state.chat;}
          return (_keyboardIsVisible() || (widget.chatRole == ChatRole.COMPRADOR && (widget.chat.estadoTransaccion == "Vendido" || widget.chat.estadoTransaccion == "Rechazada"))
          || widget.chatRole == ChatRole.VENDEDOR)
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
                        if(messageTextController.text != null && messageTextController.text.length != 0){
                          Message message = Message.fromChatWidget(
                              messageTextController.text,
                              'text',
                              Timestamp.now());
                          messageTextController.clear();
                          BlocProvider.of<MessagesBloc>(context)
                              .add(AddMessage(message, widget.chatRole));
                        }else{
                          showErrorDialog(context, "Debes intrucir un texto para poder enviar un mensaje");
                        }
                      },
                    ),
                  ),
                )
              : Container(
                  width: 65,
                  margin: EdgeInsets.fromLTRB(0, 10, 5, 15),
                  decoration: BoxDecoration(
                    color: widget.chatRole == ChatRole.COMPRADOR && widget.chat.estadoTransaccion == "Oferta"?Color.fromARGB(255, 255, 104, 104) : AppColors.secondaryBackground,
                    /*color: Color.fromARGB(255, 255, 104, 104),*/ //TODO implementar un state para compra solicitada o no
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: widget.chatRole == ChatRole.COMPRADOR && widget.chat.estadoTransaccion == "Oferta"?/*Icon(Icons.star)*/Image.asset("assets/images/cancel-order.png", width: 20, height: 20,):Icon(Icons.add_shopping_cart),
                      iconSize: 25,
                      color: Colors.white,
                      onPressed: () {
                        if(widget.chatRole == ChatRole.COMPRADOR){
                          if(widget.chat.estadoTransaccion == "Pregunta"){
                            showSlideDialogGrande(context: context, child:
                            CustomDialog.customFunctions(title: "Enviar Solicitud De Compra", description: "Una vez enviada la solicitud de compra esta no se podra cancelar", primaryButtonText: "CANCELAR", secondaryButtonText: "Solicitar Compra",
                              primaryFunction:() {
                                Navigator.of(context).pop();
                              },
                              secondaryFunction:() {
                                BlocProvider.of<MessagesBloc>(context).add(LoadMessages(widget.chat,ChatRole.COMPRADOR));
                                BlocProvider.of<MessagesBloc>(context).add(SolicitarCompra(widget.chat));
                                Navigator.of(context).pop();
                              },)

                            );
                          }else if(widget.chat.estadoTransaccion == "Oferta"){
                            showSlideDialogGrande(context: context, child:CustomDialog.customFunctions(title: "Cancelar Pedido De Compra", description: "Al cancelar la solicitud de compra el usuario no podra venderte el producto", primaryButtonText: "CANCELAR", secondaryButtonText: "Cancelar Solicitud De Compra",
                              primaryFunction:() {
                                Navigator.of(context).pop();
                              },
                              secondaryFunction:() {
                                BlocProvider.of<MessagesBloc>(context).add(LoadMessages(widget.chat,ChatRole.COMPRADOR));
                                BlocProvider.of<MessagesBloc>(context).add(CancelarSolicitudDeCompra(widget.chat));
                                Navigator.of(context).pop();
                              },) );
                            ;
                          }
                        }
//                        else{
//                          if(widget.chat.estadoTransaccion == "Oferta"){
//                            showSlideDialogGrande(context: context,child:
//                            CustomDialog.customFunctions(title: "Solicitud de Compra", description: "Aceptar o Rechazar la solicitud de compra que te envio ${widget.chat.compradorNombre}", primaryButtonText: "RECHAZAR", secondaryButtonText: "VENDER",
//                              primaryFunction:() {
//                              showSlideDialogGrande(context: context, child: CustomDialog.customFunctions(title: "Rechazar Solicitud De Compra", description: "Al rechazar la compra le llegara al usuario una notificacion diciendo que le rechazaste la compra", primaryButtonText: "CANCELAR", secondaryButtonText: "Rechazar Compra",
//                                primaryFunction:() {
//                                  Navigator.of(context).pop();
//                                },
//                                secondaryFunction:() {
//                                  BlocProvider.of<MessagesBloc>(context).add(RechazarSolicitudDeCompra(widget.chat));
//                                  Navigator.of(context).pop();
//                                },));
//                              },
//                              secondaryFunction:() {
//                                showSlideDialogGrande(context: context,child:
//                                CustomDialog.customFunctions(title: "Aceptar Solicitud De Compra", description: "Al Aceptar la compra se Rechazaran todas las otras ofertas de compra que tenias por este libro", primaryButtonText: "CANCELAR", secondaryButtonText: "Aceptar Compra",
//                                  primaryFunction:() {
//                                    Navigator.of(context).pop();
//                                  },
//                                  secondaryFunction:() {
//                                    BlocProvider.of<MessagesBloc>(context).add(AceptarSolicitudDeCompra(widget.chat));
//                                    Navigator.of(context).pop();
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (_) {
//                                              return ChatScreenBuck(chat : widget.chat,chatRole : ChatRole.VENDEDOR);}
//                                        ));
//                                  },));
//                              },));
//                          }
//                        }
                        //showCustomDialog(context);
                      },
                    ),
                    /* Container(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/images/cancel-order.png",
                      fit: BoxFit.fitHeight,),
                    )*/
                  ),
                );
          }

                )
        ],
      ),
    );
  }

  _onWillPop(BuildContext context) {
    BlocProvider.of<MessagesBloc>(context).add(UnloadMessages());
    Navigator.pop(context);
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
