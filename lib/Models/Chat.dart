import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterui/Models/User.dart';

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
  uid;
  CachedNetworkImageProvider compradorImage, vendedorImage;
  bool leidoPorElComprador, leidoPorElVendedor;
  Timestamp timestamp;

  Chat();

  Chat.fromDocumentSnapshotAsComprador(DocumentSnapshot doc) {
    nombreLibro = doc['nombreLibro'];
    publicacionId = doc['publicacionId'];
    compradorEmail = doc['compradorEmail'];
    compradorNombre = doc['compradorNombre'];
    compradorImageUrl = doc['compradorImage'];
    //compradorImage = CachedNetworkImageProvider(compradorImageUrl);
    vendedorEmail = doc['vendedorEmail'];
    vendedorNombre = doc['vendedorNombre'];
    vendedorImageUrl = doc['vendedorImage'];
    vendedorImage = CachedNetworkImageProvider(vendedorImageUrl);
    leidoPorElComprador = doc['leidoPorElComprador'];
    leidoPorElVendedor = doc['leidoPorElVendedor'];
    timestamp = doc['timestamp'];
    estadoTransaccion = doc['estadoTransaccion'];
    uid = doc.documentID;
  }

  Chat.fromDocumentSnapshotAsVendedor(DocumentSnapshot doc) {
    nombreLibro = doc['nombreLibro'];
    publicacionId = doc['publicacionId'];
    compradorEmail = doc['compradorEmail'];
    compradorNombre = doc['compradorNombre'];
    compradorImageUrl = doc['compradorImage'];
    compradorImage = CachedNetworkImageProvider(compradorImageUrl);
    vendedorEmail = doc['vendedorEmail'];
    vendedorNombre = doc['vendedorNombre'];
    vendedorImageUrl = doc['vendedorImage'];
    //vendedorImage = CachedNetworkImageProvider(vendedorImageUrl);
    leidoPorElComprador = doc['leidoPorElComprador'];
    leidoPorElVendedor = doc['leidoPorElVendedor'];
    timestamp = doc['timestamp'];
    estadoTransaccion = doc['estadoTransaccion'];
    uid = doc.documentID;
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
    vendedorNombre = user.nombre;
    vendedorEmail = user.email;
    vendedorImageUrl = user.fotoPerfilUrl;
    leidoPorElVendedor = false;
  }

  addCompradorInformation(User user){
    compradorNombre = user.nombre;
    compradorEmail = user.email;
    compradorImageUrl = user.fotoPerfilUrl;
    leidoPorElComprador = false;
  }
}