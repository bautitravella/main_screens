

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterui/Models/EstadoMessage.dart';
import 'package:flutterui/Models/chat_roles.dart';

class Message{

  String email,messageText , typeOfMessage,title;
  Timestamp sentTimestamp;
  ChatRole role;

  Message();

  Message.fromChatWidget(this.messageText,this.typeOfMessage,this.sentTimestamp);

  Message.fromAllFields(this.email,this.messageText,this.typeOfMessage,this.sentTimestamp);

  Message.fromDocumentSnapshot(DocumentSnapshot doc){
    email = doc['email'];
    messageText = doc['messageText'];
    sentTimestamp = doc['sentTimestamp'];
    typeOfMessage = doc['typeOfMessage'];
    if(doc['title'] != null) title = doc['title'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> messageMap = Map();
    messageMap['email'] = email;
    messageMap['messageText'] = messageText;
    messageMap['typeOfMessage'] = typeOfMessage;
    messageMap['sentTimestamp'] = Timestamp.now();
    messageMap['title'] = title;
    return messageMap;
  }

  @override
  String toString() {
    return 'Message{email: $email, messageText: $messageText, typeOfMessage: $typeOfMessage, sentTimestamp: $sentTimestamp}';
  }


}

Message createMessageFromDocumentSnapshot(DocumentSnapshot doc){
  try{
    String typeOfMessage = doc['typeOfMessage'];
    if(typeOfMessage != null){
      if(typeOfMessage == "text"){
        return Message.fromDocumentSnapshot(doc);
      }else if(typeOfMessage == "estado"){
        return EstadoMessage.fromDocumentSnapshot(doc);
      }
    }
  }catch (e){
    return null;
  }
  return null;
}



List<Message> messages = [
  Message.fromAllFields("agust", "holaaaa", 'text', Timestamp.now()),
  Message.fromAllFields("agust", "holaaaa", 'text', Timestamp.now()),
  Message.fromAllFields("agust", "holaaaa", 'text', Timestamp.now()),
];