import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/log_in/elije_un_rol_widget.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/log_in/verificacion_widget.dart';
import 'package:provider/provider.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BaseAuth>(
      create: (_) => Auth(),
      child: MaterialApp(
        home: MyDecider(),
    ),
    );

      MaterialApp(
      home: Provider<BaseAuth>(
        create: (_) => Auth(),
        child: MyDecider(),
      ),
    );
  }
}

class MyDecider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<BaseAuth>(context);
    return StreamBuilder<FirebaseUser> (
      stream: auth.onAuthStateChangedUser,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool loggedIn = snapshot.hasData;
          if(loggedIn){
            if(!isVerified(snapshot.data)){
              return VerificacionWidget();
            }else if(!isInformationCompleted(snapshot.data.email)){
              return ElijeUnRolWidget();
            }
            return HomeHub();
          }else{
            return FirstscreenWidget();
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
  
  bool isVerified(FirebaseUser user){
    final providers = user.providerData;
    bool isVerified = true;
    print('CANTIDAD = ${providers.length}');
    for (UserInfo userProviders in providers){
      print('MENSAJE provider = ${userProviders.providerId} ');
      if(userProviders.providerId != 'password' && userProviders.providerId != 'firebase'){
        return true;
      }else{
        isVerified = user.isEmailVerified;
      }
    }
    print('MENSAJE TRUE');
    return isVerified;

  }

  bool isInformationCompleted(String email){
    Firestore.instance.collection("Users").document(email).get().then((DocumentSnapshot ds) {
      if(ds.exists){
        print(ds.data);
        if(firebaseUserInfoCompleted(ds.data)){
          return true;
        }
      }
      return false;
    } );

  }

  bool firebaseUserInfoCompleted(Map<String,dynamic> data){
    return true;
  }

}