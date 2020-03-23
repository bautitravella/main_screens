

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class AuthRepository{

  Future<String> signInWithEmailAndPassword(String email, String password,);

  Future<String> createUserWithEmailAndPassword(String email, String password,);
  Future<String> currentUserUID();
  Future<FirebaseUser> currentUser();
  Future<void> signOut();

  Future<String> signInWithGoogle();
  Future<String> signInWithFacebook(FacebookAccessToken token);



}