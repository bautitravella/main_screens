

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterui/Models/Message.dart';

class EstadoMessage  extends Message{

  String estado;

  EstadoMessage.fromDocumentSnapshot(DocumentSnapshot documentSnapshot):super.fromDocumentSnapshot(documentSnapshot){
    this.estado = documentSnapshot['estado'];
  }
}