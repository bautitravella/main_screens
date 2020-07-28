import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/Models/Instituition.dart';
import 'package:flutterui/Models/ListTile/book_list_tile.dart';
import 'package:flutterui/Models/ListTile/string_list_tile.dart';
import 'package:flutterui/Models/Padre.dart';
import 'package:flutterui/Models/book.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/dialogs/dialog_widget/error_dialog.dart';
import 'package:flutterui/dialogs/slide_popup_dialog.dart';
import 'package:flutterui/perfiles_widgets/mi_perfil.dart';
import 'package:flutterui/size_config.dart';
import 'package:flutterui/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:animations/animations.dart';

enum ListType {cheapest , recomended,hijos,subject,career,years,colegio}

class GenericBookList extends StatefulWidget {
  
  ListType listType;
  int childIndex;
  Hijo currentChild;
  String instituition;
  String parameter;


  GenericBookList(this.instituition,this.listType);

  GenericBookList.cheapest({this.currentChild = null}){
    this.listType = ListType.cheapest;
    this.parameter = null;
  }

  GenericBookList.subject(this.instituition,{this.parameter = null}){
    this.listType = ListType.subject;
    this.currentChild = null;
  }

  GenericBookList.years(this.instituition,{this.parameter = null}){
    this.listType = ListType.years;
    this.currentChild = null;
  }

  GenericBookList.career(this.instituition,{this.parameter = null}){
    this.listType = ListType.career;
    this.currentChild = null;
  }

  GenericBookList.recomended({this.currentChild = null}){
    this.listType = ListType.recomended;
    this.parameter = null;
  }

  @override
  _GenericBookListState createState() => _GenericBookListState();
}

class _GenericBookListState extends State<GenericBookList> {

  @override
  void initState() {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context,listen: false);
    analytics.setCurrentScreen(screenName: "/home/"+ widget.listType.toString().split(".").last);
    switch(widget.listType){
      case ListType.cheapest:
        if(widget.currentChild != null){
          BlocProvider.of<BooksBloc>(context).add(LoadBooksByChild(widget.listType,widget.currentChild));
        }else {
          print("ADDED LOADBOOKSBYUSER + " + widget.listType.toString());
          BlocProvider.of<BooksBloc>(context).add(
              LoadBooksByUser(widget.listType));
        }
        break;
      case ListType.years:
        BlocProvider.of<ParticularInstituitionsInformationBloc>(context).add(LoadInstituitionInfo(instituition:widget.instituition));
        break;
      case ListType.subject:
        BlocProvider.of<ParticularInstituitionsInformationBloc>(context).add(LoadInstituitionInfo(instituition:widget.instituition));
        break;
      case ListType.career:
        BlocProvider.of<ParticularInstituitionsInformationBloc>(context).add(LoadInstituitionInfo(instituition:widget.instituition));
        break;
      case ListType.recomended:
        if(widget.currentChild != null){
          BlocProvider.of<BooksBloc>(context).add(LoadBooksByChild(widget.listType,widget.currentChild));
        }else{
          print("ADDED LOADBOOKSBYUSER + " + widget.listType.toString());
          BlocProvider.of<BooksBloc>(context).add(LoadBooksByUser(widget.listType));
        }
        break;
      default:
        break;
    }
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
          Positioned(
            top: SizeConfig.blockSizeVertical*6,
            left: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                  Navigator.pop(context);
                  },
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
                          selectTitle(widget.listType),
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
                SizedBox(height: SizeConfig.blockSizeVertical*1),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.instituition != null? Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Chip(
                          elevation: 15,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          label: Text(widget.instituition, style:  Theme.of(context).primaryTextTheme.headline2),//Tile Estado),
                        ),):
                      Container(),
                      widget.parameter != null? Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Chip(
                          elevation: 15,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          label: Text(widget.parameter, style:  Theme.of(context).primaryTextTheme.headline2),//Tile Estado),
                          deleteIcon: Icon(
                            Icons.cancel, color: Theme.of(context).iconTheme.color,
                          ),
                          onDeleted: (){
                            print("HOLAAAAAaAAAAAAAAAAAA");
                            Navigator.pop(context);
                          },
                        ),
                      ):
                      Container(
                      ),
                      SizedBox(width: 80, height: 60,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SlidingUpPanel(
                    panelBuilder: (ScrollController sc) => _scrollingList(sc),
                    maxHeight: SizeConfig.blockSizeVertical * 94,
                    minHeight: SizeConfig.blockSizeVertical * 88,
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
                        }
                        return Container();

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  String selectTitle(ListType listType){
    switch(widget.listType){
      case ListType.cheapest:
        return 'Mejores Precios';
        
      case ListType.years:
        return 'Cursos';
      case ListType.subject:
        return 'Materias';
      case ListType.career:
        return 'Carreras';
      case ListType.recomended:
        return 'Recomendados';
      default:
        break;
    }
    return '';
  }
  Widget selectList(ScrollController sc){
    if(widget.parameter!= null || widget.currentChild != null){
      return  BlocBuilder<BooksBloc,BooksBlocState>(
          builder: (context, state) {
            if (state is BooksLoadedState) {
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
    }
    switch(widget.listType){
      case ListType.cheapest:
        return  BlocBuilder<BooksBloc,BooksBlocState>(
            builder: (context, state) {
              print("SWITCH 1.0");
              if (state is BooksLoadedState){
                print("SWITCH 1.1");
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
      case ListType.recomended:
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
      case ListType.subject:
        return BlocBuilder<ParticularInstituitionsInformationBloc,ParticularInstituitionsInformationState>(
          builder: (context,state){
            if(state is InstituitionsInfoLoaded){
              //print("STATE = " + state.toString());
              if(widget.instituition != null && state.instituitionsMap != null && state.instituitionsMap.containsKey(widget.instituition)){
                School school =  state.instituitionsMap[widget.instituition];
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  itemCount: school.subjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    String str = school.subjects[index];
                    return GestureDetector(
                        onTap: (){
                          BlocProvider.of<BooksBloc>(context).add(LoadBooksByInstituition(widget.instituition,widget.listType,str));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenericBookList.subject(widget.instituition,parameter: str,),
                            ),
                          );
                        },
                        child: StringTile(str));
                  },
                );
              }
              return Container(child: Center(child: Text("Ha habido algun error, por favor volve a intentar, si el problema recurre te pedimos que nos envies un mail a buymy.customerservice@gmail.com"),),);
            }
            return Container(child: Center(child: CircularProgressIndicator(),),);
          },
        );
      case ListType.career:
        return BlocBuilder<ParticularInstituitionsInformationBloc,ParticularInstituitionsInformationState>(
          builder: (context,state){
            if(state is InstituitionsInfoLoaded){
              //print("STATE = " + state.toString());
              if(widget.instituition != null && state.instituitionsMap != null && state.instituitionsMap.containsKey(widget.instituition)){
                College college =  state.instituitionsMap[widget.instituition];
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  itemCount: college.careers.length,
                  itemBuilder: (BuildContext context, int index) {
                    String str = college.careers[index];
                    return GestureDetector(
                        onTap: (){
                          BlocProvider.of<BooksBloc>(context).add(LoadBooksByInstituition(widget.instituition,widget.listType,str));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenericBookList.subject(widget.instituition,parameter: str,),
                            ),
                          );
                        },
                        child: StringTile(str));
                  },
                );
              }
              return Container(child: Center(child: Text("Ha habido algun error, por favor volve a intentar, si el problema recurre te pedimos que nos envies un mail a buymy.customerservice@gmail.com"),),);
            }
            return Container(child: Center(child: CircularProgressIndicator(),),);
          },
        );
      case ListType.years:
        return BlocBuilder<ParticularInstituitionsInformationBloc,ParticularInstituitionsInformationState>(
          builder: (context,state){
            if(state is InstituitionsInfoLoaded){
              if(widget.instituition != null && state.instituitionsMap != null && state.instituitionsMap.containsKey(widget.instituition)){
                School school =  state.instituitionsMap[widget.instituition];
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: sc,
                  itemCount: school.years.length,
                  itemBuilder: (BuildContext context, int index) {
                    String str = school.years[index];
                    return GestureDetector(
                        onTap: () {
                          BlocProvider.of<BooksBloc>(context).add(LoadBooksByInstituition(widget.instituition,widget.listType,str));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GenericBookList.years(widget.instituition,parameter:str),
                            ),
                          );
                        },
                        child: StringTile(str));
                  },
                );
              }
              return Container(child: Center(child: Text("Ha habido algun error, por favor volve a intentar, si el problema recurre te pedimos que nos envies un mail a buymy.customerservice@gmail.com"),),);
            }
            return Container(child: Center(child: CircularProgressIndicator(),),);
          },
        );
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


