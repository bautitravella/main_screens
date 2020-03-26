import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/Models/User.dart';
import 'package:flutterui/home_hub/home_hub.dart';

import 'package:flutterui/main.dart';
import 'package:flutterui/values/values.dart';
import 'package:flutterui/dialogs/dialogs.dart';

class TerminosYCondicionesWidget extends StatelessWidget {
  void onButtonsLargeGreenPressed(BuildContext context) {}

  TextSpan terminosYCondiciones= TextSpan(
      children: [
        TextSpan( text: """El presente documento establece las condiciones mediante las cuales se regirá el uso de la aplicación móvil:""",
            style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
        ),
        TextSpan( text: """ BuyMy """,
            style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w700, fontFamily: "Sf-t")
        ),
        TextSpan( text: """(en adelante la Aplicación o App), la cual es provista por""",
            style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
        ),
        TextSpan( text: """ AGUSTÍN TORMAKH y BAUTISTA TRAVELLA """,
            style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w700, fontFamily: "Sf-t")
        ),
        TextSpan( text: """en adelante el Proveedor de la aplicación.

La aplicación funcionará como un nuevo canal para la realización de ciertas actividades con el objeto de facilitar el acceso a los usuarios de BuyMy a dichas actividades. Siendo el Usuario la persona que utiliza los servicios que brinda la App BuyMy.

El Usuario reconoce que el ingreso de su información personal, y los datos que contiene la aplicación a su disposición respecto a al servicio que brinda, lo realizan de manera voluntaria, quienes optan por acceder a esta aplicación lo hacen por iniciativa propia y son responsables del cumplimiento de las leyes. En caso de que se acceda por parte de menores de edad, deben contar con la supervisión de un adulto en todo momento desde la descarga y durante el uso de la aplicación, en el evento en que no se cumpla esta condición, le agradecemos no hacer uso de la aplicación.
 
El Usuario acepta expresamente los Términos y Condiciones, siendo condición esencial para la utilización de la aplicación. En el evento en que se encuentre en desacuerdo con estos Términos y Condiciones, solicitamos abandonar la aplicación inmediatamente. El Proveedor podrá modificar los presentes Términos y Condiciones, lo cual se entenderá aceptado por el usuario si éste continúa con el uso de la aplicación.​
 
Al aceptar este documento de Términos y Condiciones dará por aceptado el documento de Política de Privacidad.
\n""",
            style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
        ),
      ]
  );
  TextSpan alcanceYUso= TextSpan(
    text: "En la aplicación se pondrá a disposición del Usuario información y/o permitirá la realización de las transacciones determinadas o habilitadas por BuyMy. El Proveedor podrá adicionar, modificar o eliminar las funcionalidades en cualquier momento, lo cual acepta el usuario mediante la instalación de la aplicación.\n\n",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan requisitosYUso= TextSpan(
    text: """El usuario deberá contar con un dispositivo móvil inteligente (Smartphone) o Tableta con sistema operativo Android o IOS, cualquiera de estos con acceso a internet, ambos seguros y confiables. El Proveedor no será responsable por la seguridad de los equipos Smartphone propiedad de los usuarios utilizados para el acceso a la app, ni por la disponibilidad del servicio en los dispositivos en los cuales se descargue la aplicación.

La Aplicación se suministra sin garantía de ningún género, expresa o implícita, incluyendo sin limitación las garantías de calidad satisfactoria, adecuación para un fin particular o no infracción, por tanto, el Proveedor no garantiza el funcionamiento adecuado en los distintos sistemas operativos o dispositivos en los cuales se haga uso de la aplicación.

El Usuario será responsable por la modalidad que elija para su registración en la app.
\n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan obligacionesDeLosUsuarios= TextSpan(
    text: "El Usuario se obliga a usar la aplicación y los contenidos encontrados en ella de una manera diligente, correcta, lícita y en especial, se compromete a NO realizar las conductas descritas a continuación:\n\n"
      """ 
       (a) Utilizar los contenidos de forma, con fines o efectos contrarios a la ley, a la moral y a las buenas costumbres generalmente aceptadas o al orden público;
       (b) Reproducir, copiar, representar, utilizar, distribuir, transformar o modificar los contenidos de la aplicación, por cualquier procedimiento o sobre cualquier soporte, total o parcial.
       (c) Utilizar los contenidos de cualquier manera que entrañen un riesgo de daño o inutilización de la aplicación o de los contenidos o de terceros;
       (d) Suprimir, eludir o manipular el derecho de autor y demás datos identificativos de los derechos de autor incorporados a los contenidos, así como los dispositivos técnicos de protección, o cualesquiera mecanismos de información que pudieren tener los contenidos;
       (e) Emplear los contenidos y, en particular, la información de cualquier clase obtenida a través de la aplicación para distribuir, transmitir, remitir, modificar, rehusar o reportar la publicidad o los contenidos de esta con fines de venta directa o con cualquier otra clase de finalidad comercial, mensajes no solicitados dirigidos a una pluralidad de personas con independencia de su finalidad, así como comercializar o divulgar de cualquier modo dicha información;
       (f) No permitir que terceros ajenos a usted usen la aplicación móvil con su clave;
       (g) Utilizar la aplicación y los contenidos con fines lícitos y/o ilícitos, contrarios a lo establecido en estos Términos y Condiciones, o al uso mismo de la aplicación, que sean lesivos de los derechos e intereses de terceros, o que de cualquier forma puedan dañar, inutilizar, sobrecargar o deteriorar la aplicación y los contenidos o impedir la normal utilización o disfrute de esta y de los contenidos por parte de los usuarios.\n\n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t"),
  );//TODO agregar bullets
  TextSpan propiedadIntelectual= TextSpan(
      text: """Todo el material informático, gráfico, publicitario, fotográfico, de multimedia, audiovisual y de diseño, así como todos los contenidos, textos y bases de datos puestos a su disposición en esta aplicación están protegidos por derechos de autor y/o propiedad industrial cuyo titular es el Proveedor, en algunos casos, de terceros que han autorizado su uso o explotación.Todos los contenidos en la aplicación están protegidos por las normas sobre derecho de autor y por todas las normas nacionales e internacionales que le sean aplicables.

Exceptuando lo expresamente estipulado en estos Términos y Condiciones, queda prohibido todo acto de copia, reproducción, modificación, creación de trabajos derivados, venta o distribución, exhibición de los contenidos de esta aplicación, de manera o por medio alguno, incluyendo, más no limitado a, medios electrónicos, mecánicos, de fotocopiado, de grabación o de cualquier otra índole, sin el permiso previo y por escrito de el Proveedor,  titular de los respectivos derechos.

En ningún caso estos Términos y Condiciones confieren derechos, licencias ni autorizaciones para realizar los actos anteriormente prohibidos. Cualquier uso no autorizado de los contenidos constituirá una violación del presente documento y a las normas vigentes sobre derechos de autor, a las normas vigentes nacionales e internacionales sobre Propiedad Intelectual, y a cualquier otra que sea aplicable.
\n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan lincenciaParaCopiar= TextSpan(
    text: """Ninguna parte de la aplicación podrá ser reproducida o transmitida o almacenada en otro sitio web o en otra forma de sistema de recuperación electrónico.

Ya sea que se reconozca específicamente o no, las marcas comerciales, las marcas de servicio y los logos visualizados en esta aplicación pertenecen al Proveedor.

El Proveedor no interfiere, no toma decisiones, ni garantiza las relaciones que los usuarios lleguen a sostener o las vinculaciones con terceros u otros usuarios. Estas marcas de terceros se utilizan solamente para identificar los productos y servicios de sus respectivos propietarios y el patrocinio o el aval por parte de el Proveedor no se deben inferir con el uso de estas marcas comerciales.
\n\n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan integracionConOtras= TextSpan(
    text: """Los links en esta aplicación pueden mostrar contenido que no están bajo el control de el Proveedor.

Aunque esta aplicación de el Proveedor trata de suministrar links solamente a sitios y aplicaciones de terceros que cumplan con las leyes y regulaciones aplicables y las normas de el Proveedor, el Usuario debe entender que el Proveedor no tiene control sobre la naturaleza y el contenido de esos sitios y no está recomendando estos sitios, la información que contienen ni los productos o servicios de terceros.

El Proveedor no acepta responsabilidad por el contenido del sitio de un tercero con el cual existe un link de hipertexto y no ofrece garantía (explícita o implícita) en cuanto al contenido de la información en esos sitios, ya que no recomienda estos sitios.

Usted debe verificar las secciones de términos y condiciones, política legal y de privacidad de algunos otros sitios de el Proveedor o de un tercero con los cuales se enlaza.

El Proveedor no asume ninguna responsabilidad por pérdida directa, indirecta o consecuencial por el uso de su app BuyMy o un sitio de un tercero.\n\n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan usoDeInformacion= TextSpan(
    text: """El Proveedor podrá dar a conocer, transferir y/o trasmitir sus datos personales dentro y fuera del país a cualquier empresa miembro del grupo  de el Proveedor, así como a terceros a consecuencia de un contrato, ley o vínculo lícito que así lo requiera, para todo lo anterior otorgo mi autorización expresa e inequívoca.

De conformidad a lo anterior autoriza el tratamiento de su información en los términos señalados, y transfiere a el Proveedor de manera total, y sin limitación los derechos de imagen y patrimoniales de autor, de manera voluntaria, previa, explícita, informada e inequívoca.​​​

""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan responsabilidadDeElProveedor= TextSpan(
     text: """El Proveedor no será responsable por: a) Fuerza mayor o caso fortuito; b) Por la pérdida, extravío o hurto de su dispositivo móvil que implique el acceso de terceros a la aplicación móvil; c) Por errores en la digitación o accesos por parte de otro Usuario; d) Por los perjuicios, lucro cesante, daño emergente, morales, y en general sumas a cargo de el Proveedor, por los retrasos, no procesamiento de información o suspensión del servicio del operador móvil o daños en los dispositivos móviles.

"""
      ,
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan denegacionYRetiradaDelAccesoALaAplicacion= TextSpan(
    text: """El Proveedor se reserva el derecho de suspender el acceso de un Usuario a la aplicación, sin necesidad de Justificación o previa notificación a dicho Usuario.
   \n """,
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan jurisdiccion= TextSpan(
      text:
      """Estos términos y condiciones y todo lo que tenga que ver con esta aplicación, se rigen por las leyes de la República Argentina.
      \n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan usoDeInformacionNoPersonal= TextSpan(
      text:
      """El Proveedor también recolecta información no personal en forma agregada para seguimiento de datos como el número total de descargas de la aplicación, entre otros. Utilizamos esta información, que permanece en forma agregada, para entender el comportamiento de la aplicación,entre otros.
      \n""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );
  TextSpan usoDeDireccionesIP= TextSpan(
      text:
      """Una dirección de Protocolo de Internet (IP) es un conjunto de números que se asigna automáticamente a su o dispositivo móvil cuando usted accede a su Proveedor de servicios de internet, o a través de la red de área local (LAN) de su organización o la red de área amplia (WAN). Los servidores web automáticamente identifica su dispositivo móvil por la dirección IP asignada a él durante su sesión en línea.

El Proveedor podrán recolectar direcciones IP para propósitos de administración de sistemas y para auditar el uso de nuestro sitio, todo lo anterior de acuerdo con la autorización de protección de datos que se suscribe para tal efecto.
""",
      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w400, fontFamily: "Sf-t")
  );

  User user;
  TerminosYCondicionesWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 25, top: 85),
                child: Text(
                  "Terminos y\nCondiciones",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontWeight: FontWeight.w400,
                    fontSize: 38,
                    height: 1.26316,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin:
                    EdgeInsets.only(left: 28, top: 20, right: 28, bottom: 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                           /* Container(
                              margin: EdgeInsets.only(right: 64),
                              child: Text(
                                "Articulo 1",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16, right: 17),
                              child: Text(
                                "Para quien use los servicios",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 69, 79, 99),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),*/
                            Container(
                              margin:
                                  EdgeInsets.only(left: 0, top: 10, right: 3),
                              child:RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    terminosYCondiciones,
                                    TextSpan(
                                      text: "Alcance y Uso\n\n",
                                      style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    alcanceYUso,
                                    TextSpan(
                                        text: "Requisitos para uso\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    requisitosYUso,
                                    TextSpan(
                                        text: "Obligaciones de los usuarios\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    obligacionesDeLosUsuarios,
                                    TextSpan(
                                        text: "Obligaciones de los usuarios\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    propiedadIntelectual,
                                    TextSpan(
                                        text: "Licencia para copiar para uso personal \n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    lincenciaParaCopiar,
                                    TextSpan(
                                        text: "Integración con otras aplicaciones \n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    integracionConOtras,
                                    TextSpan(
                                        text: "Uso de información y privacidad\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    usoDeInformacion,
                                    TextSpan(
                                        text: "Responsabilidad de el proveedor\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    responsabilidadDeElProveedor,
                                    TextSpan(
                                        text: "Denegación y retirada del acceso a la aplicación\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    denegacionYRetiradaDelAccesoALaAplicacion,
                                    TextSpan(
                                        text: "Jurisdicción\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    jurisdiccion,
                                    TextSpan(
                                        text: "Uso de información no personal\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    usoDeInformacionNoPersonal,
                                    TextSpan(
                                        text: "Uso de direcciones IP\n\n",
                                        style: TextStyle(color: Color.fromARGB(255, 69, 79, 99), fontWeight: FontWeight.w600, fontSize: 18,fontFamily: "Sf")
                                    ),
                                    usoDeDireccionesIP,
                                  ],
                                ),
                              )
                            ),
                            Container(
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 4,
                      right: 3,
                      bottom: 10,
                      height: 53,
                      child: FlatButton(
                        onPressed: () => siguienteBtn(context),
                        color: AppColors.secondaryElement,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "ACEPTAR Y CONTINUAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  siguienteBtn(BuildContext context) {
    showLoadingDialog(context);
    //todo cambiar toda esta poronga por un buen Future.wait
    uploadData2(context).then((smt) => {
      Future.delayed(Duration(seconds: 2)).then((value) => {
        print("PASANDO A LA PROXIMA PANTALLA"),
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        ),
      }),
        }).catchError((err) {
      print("HUBO UN ERROR 1, " + err.toString());
      Navigator.pop(context);
      showErrorDialog(context,
          "Hubo un error al intentar cargar tus datos.Error: ${err.toString()}");
    }
    );
  }

  Future<void> uploadData2(BuildContext context)async{
    String downloadUrl = await uploadImage();
    user.fotoPerfilUrl = downloadUrl;
    user.hasAcceptedTerms = true;
    return Future.wait([uploadUserInformation(downloadUrl, context),createFavoritesDocument(),createTokensDocument()]);
  }


  Future uploadData(BuildContext context) {
    int amountOfTryouts = 0;
    return uploadImage()
        .then((downloadUrl) => {
              user.fotoPerfilUrl = downloadUrl,
              user.hasAcceptedTerms = true,
              uploadUserInformation(downloadUrl, context),
              createFavoritesDocument(),
              createTokensDocument(),
              print("DOWNLOAD URL  2: " + downloadUrl),
            })
        .catchError((err) {
      print("HUBO UN ERROR 1, " + err.toString());
      Navigator.pop(context);
      showErrorDialog(context,
          "Hubo un error al intentar cargar tus datos.Error: ${err.toString()}");
    });
  }

  Future<String> uploadImage() async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child("profile_images2/" + user.email + ".jpg");
    StorageUploadTask uploadTask = ref.putFile(user.fotoPerfilRaw);
    print(
        "---------------------------------------------------------Arranca la transferencia");

    String downloadUrl =
        (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
    print(
        "---------------------------------------------------------Termina la Transferencia");

    print("DOWNLOAD URL  1: " + downloadUrl);
    return downloadUrl;
  }

  Future uploadUserInformation(String downloadUrl, BuildContext context) {
    return Firestore.instance
        .collection('Users')
        .document(user.email)
        .setData(user.toMap())
        .then((value) => print("se mando bien la info a firebase"))
        .catchError((err) => {
              Navigator.pop(context),
              showErrorDialog(context,
                  "Hubo un error al intentar cargar tus datos.Error: ${err.toString()}")
            });
  }

  Future createFavoritesDocument() {
    return  Firestore.instance.collection('Users').document(user.email).collection('Favoritos').document('favoritos').setData({'favoritosList':[]});
  }

  Future createTokensDocument(){
    return Firestore.instance.collection('Users').document(user.email).collection('Tokens').document('tokens').setData({'tokensList':[]});
  }


}

void showLoadingDialog(BuildContext context) {
  showSlideDialogChico(
      context: context,
      child: LoadingDialog(),
      animatedPill: true,
      barrierDismissible: false);
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
