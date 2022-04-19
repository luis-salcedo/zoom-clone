import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  //Initialize firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firebaseStore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  //Google Sign in Setup
  signInWithGoogle() async {
    try {
      //Sign in user
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      //Gain Access to Google Account Data
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Store user data to FireBase
      UserCredential userCredentials =
          await _auth.signInWithCredential(credentials);

      User? user = userCredentials.user;
      //check if user exist
      if (user != null) {
        //check if user is a new user
        if (userCredentials.additionalUserInfo!.isNewUser) {
          //save user data in firestore database
          _firebaseStore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profileImage': user.photoURL
          });
        } else {}
      }
    } catch (e) {}
  }
}
