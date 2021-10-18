import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/models/user.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.uid,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}