import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/database_repository.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/log_in/elije_un_rol_widget.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/log_in/verificacion_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'dart:async';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BaseAuth>(
      create: (_) => Auth(),
      child: RepositoryProvider(
        create: (context) => FirebaseRepository(),
        child: BlocProvider(
          create: (BuildContext context) => UserBloc(RepositoryProvider.of<FirebaseRepository>(context)),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<BooksBloc>(
                create: (context) {
                  return BooksBloc(RepositoryProvider.of<FirebaseRepository>(context),BlocProvider.of<UserBloc>(context));
                },
              ),
            ],
            child: MaterialApp(
                home: MyDecider(),
                theme: ThemeData(
                  accentColor:AppColors.secondaryBackground,
                ),
                routes: <String, WidgetBuilder> {
                  '/home': (BuildContext context) => HomeHub(),
                  '/logOut': (BuildContext context) => FirstscreenWidget(),
                }
            ),
          ),
        ),
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
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final bool loggedIn = snapshot.hasData;
          if(loggedIn){
            if(!isVerified(snapshot.data)){
              return VerificacionWidget();
            }
            return FirestoreDecider(snapshot.data.email);
          }else{
            return FirstscreenWidget();
          }
        }
        //errorDialog(context);
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

}

class FirestoreDecider  extends StatefulWidget{

  String userEmail;
  FirestoreDecider(this.userEmail);

  @override
  FirestoreDeciderState createState() => FirestoreDeciderState(userEmail);
}

class FirestoreDeciderState extends State<FirestoreDecider>{


  Future<DocumentSnapshot> firestoreDocumentFuture;
  String email;

  FirestoreDeciderState(this.email);

  @override
  void initState(){
    super.initState();
    firestoreDocumentFuture = Firestore.instance.collection("Users").document(email).get();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LoadUser(email));
    return BlocBuilder<UserBloc,UserBlocState>(
      builder: (context, state) {
        if(state is UserLoadedState){
          print("LOADED USER = ${state.user}" );
        }else if(state is UserNotLoaded){
          print("USER  NOT LOADEEED");
        }
        return FutureBuilder(
        future: firestoreDocumentFuture,
        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }else if(snapshot.data.exists){

        print(snapshot.data.data);
        if(firebaseUserInfoCompleted(snapshot.data.data)){
        return HomeHub();
        }
        }
        return ElijeUnRolWidget(email);
        } );
      },

    );

  }


  bool firebaseUserInfoCompleted(Map<String,dynamic> data){
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['fotoPerfilUrl'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];

    if(nombre == null || apellido == null || fotoPerfil == null || hasAcceptedTerms == null || rol == null){
      return false;
    }
    return true;
  }


}

void errorDialog(BuildContext context){
  showSlideDialogChico(context: context, child: ErrorDialog(title: "Oops...",error: "me rompiste mucho las pelotas",));
}


