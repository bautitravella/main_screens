

import 'package:cloud_firestore/cloud_firestore.dart';

class Message{

  String email,messageText , typeOfMessage;
  Timestamp sentTimestamp;

  Message();

  Message.fromAllFields(this.email,this.messageText,this.typeOfMessage,this.sentTimestamp);

  Message.fromDocumentSnapshot(DocumentSnapshot doc){
    email = doc['email'];
    messageText = doc['messageText'];
    sentTimestamp = doc['sentTimestamp'];
    typeOfMessage = doc['typeOfMessage'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> messageMap = Map();
    messageMap['email'] = email;
    messageMap['messageText'] = messageText;
    messageMap['typeOfMessage'] = typeOfMessage;
    messageMap['sentTimestamp'] = Timestamp.now();

  }
}

List<Message> messages = [
  Message.fromAllFields("agust", "holaaaa", 'text', Timestamp.now()),
  Message.fromAllFields("agust", "holaaaa", 'text', Timestamp.now()),
  Message.fromAllFields("agust", "holaaaa", 'text', Timestamp.now()),
];