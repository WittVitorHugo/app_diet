import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;

  String get getEmail => _email;

  Future<bool> signUpUser(String email, String password) async {
    bool retValue = false;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email,
              password: password);
      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        retValue = true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return retValue;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retValue = false;

    try {
      UserCredential _authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (_authResult.user != null) {
        _uid = _authResult.user.uid;
        _email = _authResult.user.email;
        retValue = true;
      }
    } catch (e) {
      print(e);
    }
    return retValue;
  }
}
