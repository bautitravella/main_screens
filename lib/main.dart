import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/database_repository.dart';
import 'package:flutterui/blocs/uploads_bloc/bloc.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/log_in/registrar_info_usuario/elije_un_rol_widget.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/log_in/verificacion_widget.dart';
import 'package:flutterui/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'dart:async';

import 'Models/User.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  static BaseAuth auth = Auth();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
        Provider<BaseAuth>.value(value:auth),
      ],
      child: RepositoryProvider(
        create: (context) => FirebaseRepository(),
    child: BlocProvider(
    create: (BuildContext context) =>
    UserBloc(RepositoryProvider.of<FirebaseRepository>(context)),
    child: MultiBlocProvider(
    providers: [
    BlocProvider<BooksBloc>(
    create: (context) {
    return BooksBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context));
    },
    ),
    BlocProvider<UserBooksBloc>(
    create: (context) {
    return UserBooksBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context));
    },
    ),
    BlocProvider<FavoritesBloc>(
    create: (BuildContext context) {
    return FavoritesBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context));
    },
    ),
    BlocProvider<ColegiosBloc>(
    create: (BuildContext context) {
    return ColegiosBloc(
    RepositoryProvider.of<FirebaseRepository>(context));
    },
    ),
    BlocProvider<ChatsBloc>(create: (BuildContext context) {
    return ChatsBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context));
    }),
    BlocProvider<MessagesBloc>(create: (BuildContext context) {
    return MessagesBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context),
    BlocProvider.of<ChatsBloc>(context));
    }),
    BlocProvider<SearchBloc>(create: (BuildContext context) {
    return SearchBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context));
    }),
    BlocProvider<TokensBloc>(create: (BuildContext context) {
    return TokensBloc(
    RepositoryProvider.of<FirebaseRepository>(context),
    BlocProvider.of<UserBloc>(context));
    }),
    BlocProvider<UploadsBloc>(
    create: (BuildContext context){
    return UploadsBloc(RepositoryProvider.of<FirebaseRepository>(context));
    },
    ),
    BlocProvider<EconomicosBloc>(
    create: (BuildContext context){
    return EconomicosBloc(RepositoryProvider.of<FirebaseRepository>(context),BlocProvider.of<UserBloc>(context));
    },
    ),
    ],
    child: MaterialApp(
    //home: MyDecider(),
    theme: ThemeData(
    accentColor: AppColors.secondaryBackground,
    ),
    navigatorObservers: [
    FirebaseAnalyticsObserver(analytics: analytics),
    ],
    routes: <String, WidgetBuilder>{
    '/home': (BuildContext context) => HomeHub(),
    '/logOut': (BuildContext context) => FirstscreenWidget(),
    '/': (BuildContext context) => MyDecider(),
    }),
    ),
    ),
    ),
    );
    return Provider<BaseAuth>(
      create: (_) => Auth(),

    );
  }
}


class MyDecider extends StatefulWidget {

  @override
  MyDeciderState createState() {
    return MyDeciderState();
  }}
class MyDeciderState extends State<MyDecider> {


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<BaseAuth>(context);
    return StreamBuilder<FirebaseUser>(
      stream: auth.onAuthStateChangedUser,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool loggedIn = snapshot.hasData;
          if (loggedIn) {
            if (!isVerified(snapshot.data)) {
              return VerificacionWidget();
            }
            return FirestoreDecider(snapshot.data.email);
          } else {
            return FirstscreenWidget();
          }
        }
        //errorDialog(context);
        return CircularProgressIndicator();
      },
    );
  }

  bool isVerified(FirebaseUser user) {
    final providers = user.providerData;
    bool isVerified = true;
    //print('CANTIDAD = ${providers.length}');
    for (UserInfo userProviders in providers) {
      //print('MENSAJE provider = ${userProviders.providerId} ');
      if (userProviders.providerId != 'password' &&
          userProviders.providerId != 'firebase') {
        return true;
      } else {
        isVerified = user.isEmailVerified;
      }
    }
    //print('MENSAJE TRUE');
    return isVerified;
  }
}



class FirestoreDecider extends StatefulWidget {
  String userEmail;
  FirestoreDecider(this.userEmail);

  @override
  FirestoreDeciderState createState() => FirestoreDeciderState(userEmail);
}

class FirestoreDeciderState extends State<FirestoreDecider> {
  Future<DocumentSnapshot> firestoreDocumentFuture;
  String email;
  StreamSubscription iosSubscription;

  FirestoreDeciderState(this.email);

  @override
  void initState() {
    super.initState();
    firestoreDocumentFuture =
        Firestore.instance.collection("Users").document(email).get();
    BlocProvider.of<UserBloc>(context).add(LoadUser(email));
    final FirebaseMessaging _fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }


    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(Platform.isIOS?message['aps']['alert']['title']:message['notification']['title']),
              subtitle: Text(Platform.isIOS?message['aps']['alert']['body']:message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<UserBloc, UserBlocState>(
      condition: (prevState,currentState){
        if(prevState is UserLoadedState && currentState is UserLoadedState){
          return false;
        }else if(prevState == currentState){
          return false;
        }else if(currentState is UserLoadedState && (prevState==InitialUserBlocState || prevState == UserLoadingState)){
          return true;
        }else if(prevState is UserLoadedState && currentState is InitialUserBlocState){
          return true;
        }
      },
      listener: (context,state){
        if (state is UserLoadedState) {
          print("LOADED USER = ${state.user}");

          if (firebaseUserInfoCompleted2(state.user)) {
            BlocProvider.of<TokensBloc>(context).add(AddToken());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeHub(),
              ),
            );

          }

        } else if (state is UserNotLoadedState) {
          print("USER  NOT LOADEEED");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ElijeUnRolWidget(email),
            ),
          ); ;
        }else if(state is InitialUserBlocState){
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
        }
      },
      child: Scaffold(
            body: Container(
              margin: EdgeInsets.all(1),
              child: Center(child: Image.asset('assets/images/buymy-hd.png'))
            ),
          ),

//      builder: (context, state) {
//        if (state is UserLoadedState) {
//          print("LOADED USER = ${state.user}");
//
//          if (firebaseUserInfoCompleted2(state.user)) {
//            BlocProvider.of<TokensBloc>(context).add(AddToken());
//            return HomeHub();
//          }
//
//        } else if (state is UserNotLoadedState) {
//          print("USER  NOT LOADEEED");
//          return ElijeUnRolWidget(email);
//        }//if(state is InitialUserBlocState)
//
//          BlocProvider.of<UserBloc>(context).add(LoadUser(email));
//          return Scaffold(
//            body: Container(
//              margin: EdgeInsets.all(1),
//              child: Center(child: Image.asset('buymy-logo.png'))
//            ),
//          );
//      },
    );
  }

  bool firebaseUserInfoCompleted2(User user) {
    if (user.nombre == null ||
        user.apellido == null ||
        user.fotoPerfilUrl == null ||
        user.hasAcceptedTerms == null) {
      return false;
    }
    return true;
  }

  bool firebaseUserInfoCompleted(Map<String, dynamic> data) {
    String nombre = data['nombre'];
    String apellido = data['apellido'];
    String fotoPerfil = data['fotoPerfilUrl'];
    bool hasAcceptedTerms = data['hasAcceptedTerms'];
    String rol = data['rol'];

    if (nombre == null ||
        apellido == null ||
        fotoPerfil == null ||
        hasAcceptedTerms == null ||
        rol == null) {
      return false;
    }
    return true;
  }
}

void errorDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: ErrorDialog(
        title: "Oops...",
        error: "me rompiste mucho las pelotas",
      ));
}
