import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_diet/models/user.dart';

class CurrentUser extends ChangeNotifier {
  late OurUser _currentUser;

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

  Future<bool> signUpUser(String email, String password) async {
    bool retValue = false;
    
    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user != null) {
        retValue = true;
      }
    } catch (e) {
      print(e);
    }
    return retValue;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retValue = false;

    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user != null) {
        _currentUser.uid = _userCredential.user.uid;
        _currentUser.email = _userCredential.user.email;
        retValue = true;
      }
    } catch (e) {
      print(e);
    }
    return retValue;
  }
}
