import 'dart:async';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;
  Stream<FirebaseUser> get onAuthStateChangedUser;
  Future<String> signInWithEmailAndPassword(String email, String password,);
  Future<bool> isVerified();
  Future sendResetEmail(String email);
  Future<String> createUserWithEmailAndPassword(String email, String password,);
  Future<String> currentUserUID();
  Future<FirebaseUser> currentUser();
  Future<void> signOut();
  Future<FirebaseUser> signInWithApple({List<Scope> scopes = const []});
  Future<String> signInWithGoogle();
  Future<String> signInWithFacebook(FacebookAccessToken token);
}

class Auth extends BaseAuth{
  FirebaseAnalytics analytics = FirebaseAnalytics();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var _facebookLogin = FacebookLogin();


  @override
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged
      .map((FirebaseUser user ) => user?.uid,);

  @override
  Stream<FirebaseUser> get onAuthStateChangedUser => _firebaseAuth.onAuthStateChanged;
  
  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    analytics.logSignUp(signUpMethod: "email");
    final user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  @override
  Future<FirebaseUser> currentUser() async {

    return (await _firebaseAuth.currentUser());
  }

  @override
  Future<String> currentUserUID() async{
    return (await currentUser()).uid;
  }




  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async{
    analytics.logLogin(loginMethod:"email");
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }

  @override
  Future<String> signInWithGoogle()async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _auth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _auth.idToken, accessToken: _auth.accessToken);
    analytics.logLogin(loginMethod: "Google");
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }

  Future<FirebaseUser> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request

    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider( providerId: 'apple.com',);
        final credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
          String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          final userInfoUpdate = new UserUpdateInfo();
          userInfoUpdate.displayName = displayName;
          await firebaseUser.updateProfile(userInfoUpdate );
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }


  @override
  Future<void> signOut() async{
    try {
      _googleSignIn.signOut();
      _facebookLogin.logOut();
    }catch (e){
      print("ERROR SIGNOUT TRY " + e.toString());
    }
    String token = await _firebaseMessaging.getToken();
    FirebaseUser user = await currentUser();
    try{
      Firestore.instance.collection("Users").document(user.email).collection('Tokens').document('tokens').updateData({'tokensList':FieldValue.arrayRemove([token])}).catchError((e )=> print("SMT"));

    }catch(e){
      print("AUTH SIGN OUT ERROR = " + e.toString());
    }
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<String> signInWithFacebook(FacebookAccessToken token) async {
    AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: token.token);
    AuthResult firebaseUser = await _firebaseAuth.signInWithCredential(credential);
    analytics.logLogin(loginMethod: "Facebook");
    return firebaseUser.user.uid;

  }

  Future<bool> isVerified()async{
    FirebaseUser user = await currentUser();
    user.reload();
    return user.isEmailVerified;

  }

  Future sendResetEmail(String email){
    if(email != null && email.length != 0){
      return _firebaseAuth.sendPasswordResetEmail(email: email);
    }
  }

}