import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_diet/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  final OurUser _currentUser = OurUser(
      uid: '', fullName: '', email: '', accountCreated: Timestamp.now());

  OurUser get getCurrentUser => _currentUser;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _firebaseUser = await FirebaseAuth.instance.currentUser;
      _currentUser.uid = _firebaseUser.uid;
      _currentUser.email = _firebaseUser.email;
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await FirebaseAuth.instance.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(String email, String password) async {
    String retValue = "error";

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      retValue = "success";
    } on FirebaseAuthException catch (e) {
      retValue = e.message;
    }
    return retValue;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retValue = "error";

    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _currentUser.uid = _userCredential.user.uid;
      _currentUser.email = _userCredential.user.email;
      retValue = "success";
    } catch (e) {
      print(e);
    }
    return retValue;
  }

  Future<String> loginUserWithGoogle(String email, String password) async {
    String retValue = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _currentUser.uid = _userCredential.user.uid;
      _currentUser.email = _userCredential.user.email;
      retValue = "success";
    } catch (e) {
      print(e);
    }
    return retValue;
  }
}
