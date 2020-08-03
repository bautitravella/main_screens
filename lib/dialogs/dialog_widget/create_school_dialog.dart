import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/WidgetsCopy/textfield_widget.dart';
import 'package:flutterui/blocs/bloc.dart';
import 'package:flutterui/book_widget/edit_book.dart';
import 'package:flutterui/dialogs/dialog_widget/succesfull_dialog.dart';
import 'package:flutterui/values/colors.dart';
import '../../size_config.dart';
import '../dialogs.dart';

Widget createCourseTag(BuildContext context, String str,Function(String) fn){
  return Container(
    margin: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
    child: Chip(
      label: Text(str, textAlign: TextAlign.center),
      labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
      deleteIcon:
      Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
      onDeleted: () {fn(str);},
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15.0),
      ),
      labelStyle: TextStyle(
          fontFamily: "Sf-r",
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).dialogBackgroundColor),
      backgroundColor: AppColors.secondaryBackground,
    ),
  );
}


class CreateSchoolDialogWidget extends StatefulWidget {
  String email;

  CreateSchoolDialogWidget(this.email);

  @override
  State<StatefulWidget> createState() {
    return CreateSchoolDialogState();
  }
}

class CreateSchoolDialogState extends State<CreateSchoolDialogWidget> {
  List<String> coursesList = ["Matematica", "Deporte", "Historia", "Geografia"];
  //TODO: esto no termina de funcionar porque no se como hacer para que se
  // agreguen automaticamente los cosos de estas materias.
  List<CourseTag> coursesWidgetList = List();
  TextEditingController coursesTextEditingController = new TextEditingController(),
      colegioNameTextEditingController = new TextEditingController();
  String courseErrorString = '';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String input = "";
    return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 8,
          right: SizeConfig.blockSizeHorizontal * 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Enviar solicitud para\nagregar un colegio",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8),
                Text(
                  "La solicitud sera revisada por nuestro equipo antes de agregar el colegio seleccionado. Una vez aceptada o rechazada te enviaremos un mail con nuestra decision.",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Nombre del colegio a agregar",
              style: Theme.of(context).textTheme.headline2,
            ),
            BeautyTextfield(
              controller: colegioNameTextEditingController,
              width: double.maxFinite, //REQUIRED
              height: 50, //REQUIRED
              accentColor: Colors.white, // On Focus Color//Text Color
              backgroundColor: Theme.of(context).hintColor,
              autofocus: false,
              maxLines: 1,
              margin: EdgeInsets.only(top: 10),
              cornerRadius: BorderRadius.all(Radius.circular(15)),
              duration: Duration(milliseconds: 300),
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.done, //REQUIRED
              obscureText: false, //REQUIRED
              suffixIcon: Icon(Icons.remove_red_eye),
              onClickSuffix: () {
                print('Suffix Clicked');
              },
              onTap: () {
                print('Click');
              },
              onChanged: (text) {
                print(text);
              },
              onSubmitted: (data) {
                print(data.length);
              },
            ),
            SizedBox(height: 40),
            Text(
              "Materias de tu año",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 8),
            Text(
              "Podras agregar una por una las materias correspondientes de tu año",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BeautyTextfield(
                  width: SizeConfig.blockSizeHorizontal * 60, //REQUIRED
                  height: 50, //REQUIRED
                  accentColor: Colors.white, // On Focus Color//Text Color
                  backgroundColor: Theme.of(context).hintColor,
                  autofocus: false,
                  maxLines: 1,
                  margin: EdgeInsets.only(top: 10),
                  cornerRadius: BorderRadius.all(Radius.circular(15)),
                  duration: Duration(milliseconds: 300),
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done, //REQUIRED
                  obscureText: false, //REQUIRED
                  suffixIcon: Icon(Icons.remove_red_eye),
                  controller: coursesTextEditingController,
                  onClickSuffix: () {
                    print('Suffix Clicked');
                  },
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (String value) {
                    input = value;
                  },
                  onSubmitted: (data) {
                    print(data.length);
                  },
                ),
                SizedBox(width: 10),
                FlatButton(
                    child: Icon(
                      Icons.move_to_inbox,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      String course = coursesTextEditingController.text;

                      if (course != null) {
                        course = course.trim();
                        setState(() {
                          if (coursesList.contains(course)) {
                            //avisamos al usuario que no se agrego a la lista porque esta repetido
                            courseErrorString = "No se puede agregar a la lista \"" +course + "\" ya que se encuentra repetido";
                          }
                          else if(course.isEmpty || course.length <3){
                            courseErrorString = "El nombre de la materia debe ser de por lo menos 3 letras";
                          } else {
                            //lo agregamos a la lista
                            coursesWidgetList.add(CourseTag(course,deleteCourseTag));
                            coursesList.add(course);
                            courseErrorString = '';
                            coursesTextEditingController.clear();
                          }
                        });
                      }
                    })
              ],
            ),
            SizedBox(height: 25),
            //TODO: @Trave elegite como queres displayear este texto
            Container(
              child:Text(courseErrorString,style:Theme.of(context).textTheme.subtitle2,),
            ),
            Wrap(
              children: coursesWidgetList,
            ),
            SizedBox(height: 80),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Sf-r",
                      color: Theme.of(context).iconTheme.color.withAlpha(200),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Sf-r",
                      color: AppColors.secondaryBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    String schoolName = colegioNameTextEditingController.text.trim();
                    if(schoolName != null && schoolName.isNotEmpty && schoolName.length > 4){
                      BlocProvider.of<UploadsBloc>(context).add(AddSchool(
                          colegioNameTextEditingController.text,coursesList,widget.email));
                      Navigator.pop(context);
                      showSchoolDialogSent();
                    }else{
                      showErrorDialog(context," El nombre del colegio no se completo");
                    }


                  },
                )
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  deleteCourseTag(String str){
    setState(() {
      coursesList.remove(str);
      for(int i =0;i<coursesWidgetList.length;i++){
        if(coursesWidgetList[i].str == str){
          coursesWidgetList.removeAt(i);
          break;
        }
      }
    });
  }

  void showSchoolDialogSent() {
    showSlideDialogChico(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        context: context,
        child: SuccesfullDialog(title: "Felicitaciones", body: "Tu solicitud sera revisada en la brevedad", )
    );
  }

}


class CourseTag extends StatelessWidget{

  final String str;
  final Function(String) fn;

  const CourseTag(this.str,this.fn);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
      child: Chip(
        label: Text(str, textAlign: TextAlign.center),
        labelPadding: EdgeInsets.only(top: 4, bottom: 4, right: 10, left: 10),
        deleteIcon:
        Icon(Icons.cancel, color: Theme.of(context).dialogBackgroundColor),
        onDeleted: () {fn(str);},
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
        labelStyle: TextStyle(
            fontFamily: "Sf-r",
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).dialogBackgroundColor),
        backgroundColor: AppColors.secondaryBackground,
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is CourseTag &&
              runtimeType == other.runtimeType &&
              str == other.str;

  @override
  int get hashCode => super.hashCode ^ str.hashCode;
}