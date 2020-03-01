import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/Models/book.dart';

class Chat {
  String nombreLibro,
      publicacionId,
      compradorEmail,
      compradorImageUrl,
      compradorNombre,
      vendedorEmail,
      vendedorImageUrl,
      vendedorNombre,
      estadoTransaccion,
  uid,
  lastMessage;
  CachedNetworkImageProvider compradorImage, vendedorImage;
  bool leidoPorElComprador, leidoPorElVendedor;
  Timestamp timestamp,lastMessageTimestamp;

  Chat();


  Chat.fromDocumentSnapshot(DocumentSnapshot doc) {
    nombreLibro = doc['nombreLibro'];
    publicacionId = doc['publicacionId'];
    compradorEmail = doc['compradorEmail'];
    compradorNombre = doc['compradorNombre'];
    compradorImageUrl = doc['compradorImage'];
    compradorImage = CachedNetworkImageProvider(compradorImageUrl);
    vendedorEmail = doc['vendedorEmail'];
    vendedorNombre = doc['vendedorNombre'];
    vendedorImageUrl = doc['vendedorImage'];
    vendedorImage = CachedNetworkImageProvider(vendedorImageUrl);
    leidoPorElComprador = doc['leidoPorElComprador'];
    leidoPorElVendedor = doc['leidoPorElVendedor'];
    timestamp = doc['timestamp'];
    estadoTransaccion = doc['estadoTransaccion'];
    uid = doc.documentID;
    if(doc['lastMessage'] != null) lastMessage = doc['lastMessage'];
    if(doc['lastMessageTimestamp'] != null) lastMessageTimestamp = doc['lastMessageTimestamp'];
  }

  Chat.fromBook(Book book){
    this.vendedorImage = book.imageVendedor;
    this.vendedorImageUrl = book.imageVendedorUrl;
    this.vendedorNombre = book.nombreVendedor + " " + book.apellidoVendedor;
    this.vendedorEmail = book.emailVendedor;
    this.leidoPorElVendedor = false;
    this.publicacionId = book.uid;
    this.nombreLibro = book.nombreLibro;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> doc = Map();
    doc['nombreLibro'] = nombreLibro;
    doc['publicacionId'] = publicacionId;
    doc['compradorEmail'] = compradorEmail;
    doc['compradorNombre'] = compradorNombre;
    doc['compradorImage'] = compradorImageUrl;
    doc['vendedorEmail'] = vendedorEmail;
    doc['vendedorNombre'] = vendedorNombre;
    doc['vendedorImage'] = vendedorImageUrl;
    doc['leidoPorElComprador'] = leidoPorElComprador;
    doc['leidoPorElVendedor'] = leidoPorElVendedor;
    doc['timestamp'] = Timestamp.now();
    doc['estadoTransaccion'] = estadoTransaccion;
    return doc;
  }

  addVendedorInformation(User user){
    vendedorNombre = user.nombre + " " + user.apellido;
    vendedorEmail = user.email;
    vendedorImageUrl = user.fotoPerfilUrl;
    vendedorImage = user.fotoPerfil;
    leidoPorElVendedor = false;
  }

  addCompradorInformation(User user){
    compradorNombre = user.nombre + " " + user.apellido;
    compradorEmail = user.email;
    compradorImageUrl = user.fotoPerfilUrl;
    compradorImage = user.fotoPerfil;
    leidoPorElComprador = false;
  }

  @override
  String toString() {
    return 'Chat{nombreLibro: $nombreLibro, publicacionId: $publicacionId, compradorEmail: $compradorEmail, compradorImageUrl: $compradorImageUrl, compradorNombre: $compradorNombre, vendedorEmail: $vendedorEmail, vendedorImageUrl: $vendedorImageUrl, vendedorNombre: $vendedorNombre, estadoTransaccion: $estadoTransaccion, uid: $uid, vendedorImage: $vendedorImage, leidoPorElVendedor: $leidoPorElVendedor, timestamp: $timestamp}';
  }


}
