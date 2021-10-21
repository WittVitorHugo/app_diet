import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/models/user.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";
    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser(uid: uid, email: '', fullName: '', accountCreated: Timestamp.now(), groupId: '');
    try {
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data()["fullName"];
      retVal.accountCreated = _docSnapshot.data()["accountCreated"];
      retVal.groupId = _docSnapshot.data()["groupId"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
