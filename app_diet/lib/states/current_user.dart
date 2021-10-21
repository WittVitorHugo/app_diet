import 'package:app_diet/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_diet/models/user.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser(uid: '', fullName: '', email: '', accountCreated: Timestamp.now(), groupId: '');

  OurUser get getCurrentUser => _currentUser;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _firebaseUser = await FirebaseAuth.instance.currentUser;
      _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await FirebaseAuth.instance.signOut();
      _currentUser = OurUser(uid: '', fullName: '', email: '', accountCreated: Timestamp.now(), groupId: '');
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = "error";
    OurUser _user = OurUser(uid: '', fullName: '', email: '', accountCreated: Timestamp.now(), groupId: '');
  
    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _user.uid = _userCredential.user.uid;
      _user.email = _userCredential.user.email;
      _user.fullName = fullName;
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on FirebaseAuthException catch (e) {
      retVal = e.message;
    }
    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _currentUser = await OurDatabase().getUserInfo(_userCredential.user.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> loginUserWithGoogle(String email, String password) async {
    String retVal = "error";
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
      _currentUser = await OurDatabase().getUserInfo(_userCredential.user.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
