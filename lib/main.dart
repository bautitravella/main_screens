import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Themes/AppStateNotifier.dart';
import 'package:flutterui/Themes/AppTheme.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/blocs/database_repository.dart';
import 'package:flutterui/blocs/uploads_bloc/bloc.dart';
import 'package:flutterui/home_hub/home_hub.dart';
import 'package:flutterui/home_hub/rincon.dart';
import 'package:flutterui/log_in/AppleSignInAvailable.dart';
import 'package:flutterui/log_in/registrar_info_usuario/elije_un_rol_widget.dart';
import 'package:flutterui/log_in/firstscreen_widget.dart';
import 'package:flutterui/log_in/verificacion_widget.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/dialogs/dialogs.dart';
import 'dart:async';

import 'Models/User.dart';

void main() async  {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: App(),
  ));
}

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static BaseAuth auth = Auth();



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
        Provider<BaseAuth>.value(value: auth),
        ChangeNotifierProvider<AppStateNotifier>.value(value: AppStateNotifier()),
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
                create: (BuildContext context) {
                  return UploadsBloc(
                      RepositoryProvider.of<FirebaseRepository>(context));
                },
              ),
              BlocProvider<EconomicosBloc>(
                create: (BuildContext context) {
                  return EconomicosBloc(
                      RepositoryProvider.of<FirebaseRepository>(context),
                      BlocProvider.of<UserBloc>(context));
                },
              ),
              BlocProvider<IndividualDocumentsBloc>(
                create: (BuildContext context){
                  return IndividualDocumentsBloc(RepositoryProvider.of<FirebaseRepository>(context));
                },
              ),
              BlocProvider<SimilarBooksBloc>(
                create: (BuildContext context){
                  return SimilarBooksBloc(RepositoryProvider.of<FirebaseRepository>(context));
                },
              ),
              BlocProvider<ParticularInstituitionsInformationBloc>(
                create: (BuildContext context){
                  return ParticularInstituitionsInformationBloc(RepositoryProvider.of<FirebaseRepository>(context));
                },
              ),


            ],
            child: Consumer<AppStateNotifier>(
              builder: (context, appState, child) {
                return MaterialApp(
                  //home: MyDecider(),
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                   /* themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,*/

                    navigatorObservers: [
                      FirebaseAnalyticsObserver(analytics: analytics),
                    ],
                    routes: <String, WidgetBuilder>{
                      '/home': (BuildContext context) => HomeHub(),
                      '/logOut': (BuildContext context) => FirstscreenWidget(),
                      '/': (BuildContext context) => MyDecider(),
                    });


              },
            ),
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
  }
}

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
            FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
            analytics.setUserId(snapshot.data.email);
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
    //firestoreDocumentFuture =
        //Firestore.instance.collection("Users").document(email).get();
    try{
      BlocProvider.of<UserBloc>(context).add(LoadUser(email));
    }catch(e){
      print("MAIN FIRESTORE DECIDER ERROR");
    }

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
        MessagesBlocState messagesBlocState =
            BlocProvider.of<MessagesBloc>(context).state;
        print("onMessage messages state = " + messagesBlocState.toString());
        if (!(messagesBlocState is MessagesLoaded)) {
          /*showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(Platform.isIOS
                    ? message['aps']['alert']['title']
                    : message['notification']['title']),
                subtitle: Text(Platform.isIOS
                    ? message['aps']['alert']['body']
                    : message['notification']['body'],
                    style: TextStyle(
                      fontFamily: "Sf",
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    )
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: TextStyle(color: Colors.red)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          )*/
          _showNotificationDialog(context, message)
          ;
        }
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

  void _showNotificationDialog(BuildContext context, message) {
    showSlideDialogNotification(
        context: context,
        child: Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3, right: SizeConfig.blockSizeHorizontal*3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            /*  CircleAvatar(
                radius: 25,
                child: Image.asset("assets/images/user_default_pic-19.png"),
              ),*/
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal*80,
                    child: Text(Platform.isIOS
                        ? message['aps']['alert']['title']
                        : message['notification']['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Sf-r",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: SizeConfig.blockSizeHorizontal*80,
                    child: Text(Platform.isIOS
                        ? message['aps']['alert']['body']
                        : message['notification']['body'],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontFamily: "Sf",
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    int time = 5;
    return BlocListener<UserBloc, UserBlocState>(
      condition: (prevState, currentState) {
        print("prevState = " + prevState.toString() + " || nextState = " + currentState.toString());

        if (prevState is UserLoadedState && currentState is UserLoadedState) {
          return false;
        } else if (prevState == currentState) {
          return false;
        } else if (currentState is UserLoadedState &&
            (prevState == InitialUserBlocState ||
                prevState == UserLoadingState)) {
          return true;
        } else if (prevState is UserLoadedState &&
            currentState is InitialUserBlocState) {
          return true;
        }
      },
      listener: (context, state) {
        if (state is UserLoadedState) {
          print("LOADED USER = ${state.user}");

          if (firebaseUserInfoCompleted2(state.user)) {
            BlocProvider.of<TokensBloc>(context).add(AddToken());
            List<String> colegios = state.user.getColegios();
            String colegioNoSeleccionado = "colegio NO seleccionado";
            /*if(true){*/ //TODO desabilite esta cosa, No me acuerdo que hacia.
            if(colegios.contains(colegioNoSeleccionado)){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Rincon(state.user),
                ),
              );
            }else{

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeHub(),
              ),
            );
          }}
        } else if (state is UserNotLoadedState) {
          print("USER  NOT LOADEEED");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ElijeUnRolWidget(email),
            ),
          );
          ;
        } else if (state is InitialUserBlocState) {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
        }
      },
      child: WillPopScope(
        onWillPop:() =>  _onWillPop(),
        child: Scaffold(
          body: Container(
              margin: EdgeInsets.all(1),
              child: Center(child: Image.asset('assets/images/buymy-hd.png', scale: 2.5,))),
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

  _onWillPop() {
    BlocProvider.of<UserBloc>(context).add(UnloadUser());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FirstscreenWidget(),
      ),
    );
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
