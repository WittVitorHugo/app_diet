import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_diet/services/database.dart';
import 'package:app_diet/models/user.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser(
    uid: '',
    fullName: '',
    email: '',
    accountCreated: Timestamp.now(),
    groupId: '',
  );

  OurUser get getCurrentUser => _currentUser;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _firebaseUser = FirebaseAuth.instance.currentUser;
      _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
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
      _currentUser = OurUser(
        uid: '',
        fullName: '',
        email: '',
        accountCreated: Timestamp.now(),
        groupId: '',
      );
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName, String groupId) async {
    String retVal = "error";
    OurUser _user = OurUser(
      uid: '',
      fullName: '',
      email: '',
      accountCreated: Timestamp.now(),
      groupId: '',
    );

    try {
      UserCredential _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _user.uid = _userCredential.user.uid;
      _user.email = _userCredential.user.email;
      _user.fullName = fullName;
      _user.groupId = groupId;
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
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

}
