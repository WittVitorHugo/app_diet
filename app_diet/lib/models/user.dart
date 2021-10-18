import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  late String email;
  late String fullName;
  late Timestamp accountCreated;

  OurUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.accountCreated,
  });
}
