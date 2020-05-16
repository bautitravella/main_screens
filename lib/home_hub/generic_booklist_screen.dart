import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/ListTile/book_list_tile.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialog_widget/error_dialog.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum ListType {Economicos , recomendados,hijos,materia,carrera,curso,colegio}

class GenericBookList extends StatefulWidget {
  
  ListType listType;
  int childIndex;
  
  GenericBookList(this.listType,{this.childIndex});

  @override
  _GenericBookListState createState() => _GenericBookListState();
}

class _GenericBookListState extends State<GenericBookList> {

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/"+ widget.listType.toString().split(".").last);
    BlocProvider.of<EconomicosBloc>(context).add(LoadUserEconomicosBooks());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            height: SizeConfig.blockSizeVertical * 100,
          ),
          Positioned(
            left: 0,
            top: SizeConfig.blockSizeVertical * 6,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                height: SizeConfig.blockSizeVertical * 45,
                child: Image.asset(
                  "assets/images/destacados-image.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
                    /*body: Container(color: Colors.red,
                    constraints: BoxConstraints.expand(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: SizeConfig.blockSizeVertical * 15,
                          right: 0,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 45,
                              child: Image.asset(
                                "assets/images/destacados-image.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 12,
                          left: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Explorar",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 8,
                              ),
                              categoryScroll,
                            ],
                          ),
                        ),
                      ],
                    ),),*/
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 94,
                    minHeight: SizeConfig.blockSizeVertical * 94,
                    color: Colors.transparent,
                    backdropEnabled: false,
                    backdropColor: AppColors.secondaryBackground,
                    parallaxEnabled: true,
                    parallaxOffset: 1.2,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.transparent,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 143,
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Positioned(
                  right: 0,
                  top: 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 138,
                      height: 143,
                      child: Image.asset(
                        "assets/images/round-underpic-shade.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MiPerfil(),
                        ),
                      );
                    },
                    child: BlocBuilder<UserBloc,UserBlocState>(
                      builder: (context,state){
                        if(state is UserLoadedState){
                          return CircleAvatar(
                            radius: 27.0,
                            backgroundImage: state.user.getProfileImage(),
                          );
                          /*Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2, //
                                ),
                                borderRadius: new BorderRadius.circular(100)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Hero(
                                tag: 'avatar',
                                child: Image(
                                  image: state.user.getProfileImage(),
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          )*/
                        }
                        return Container();

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*Positioned(
            top: SizeConfig.blockSizeVertical * 10,
            left: 28,
            child: Text(
              "Explorar",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _scrollingList(ScrollController sc) {
    //ESTE ES EL QUE TENES QUE USAR Y ACA SE SUPONE QUE DEBERIAS PODER USAR EL CONTEXT
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 5,
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios),
                iconSize: 26,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },),
              Container(
                width: SizeConfig.blockSizeHorizontal*50,
                child: Text(
                  'Materias',
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Sf-r',
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30)),
              child: selectList(sc),
            ),
          ),
        ),
      ],
    );



  }


  Widget selectList(ScrollController sc){
    switch(widget.listType){
      case ListType.Economicos:
        return  BlocBuilder<EconomicosBloc,EconomicosBlocState>(
            builder: (context, state) {
              if (state is EconomicosBooksLoadedState) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  itemCount: state.books.length,
                  itemBuilder: (BuildContext context, int index) {
                    Book book = state.books[index];
                    return BookTile(book);
                  },
                );
              }
              return Container();
            });
      case ListType.recomendados:
        return BlocBuilder<BooksBloc,BooksBlocState>(
            builder: (context, state) {
              if(state is BooksLoadedState){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  itemCount: state.books.length,
                  itemBuilder: (BuildContext context, int index) {
                    Book book = state.books[index];
                    return BookTile(book);
                  },
                );
              }
              return Center(child: CircularProgressIndicator(),);
            });
      default:
        return Container(child: Center(child: Text("PARECE QUE TODAVIA NO TENEMOS PREPARADA ESTA PANTALLA"),),);
    }
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
}

