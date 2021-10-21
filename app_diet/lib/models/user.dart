import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OurUser {
  String uid;
  String email;
  String fullName;
  Timestamp accountCreated;
  String groupId;

  OurUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.accountCreated,
    required this.groupId,
  });
}
