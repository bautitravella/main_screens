import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(String email, String password,);

  Future<String> createUserWithEmailAndPassword(String email, String password,);
  Future<String> currentUserUID();
  Future<FirebaseUser> currentUser();
  Future<void> signOut();

  Future<String> signInWithGoogle();
}

class Auth extends BaseAuth{
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged
      .map((FirebaseUser user ) => user?.uid,);
  
  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
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
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }

  @override
  Future<String> signInWithGoogle()async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _auth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _auth.idToken, accessToken: _auth.accessToken);

    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

}