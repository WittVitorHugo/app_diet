import 'package:cloud_firestore/cloud_firestore.dart';

class OurGroup {
  String id;
  String name;
  String leader;
  List<String> members;
  Timestamp groupCreated;

  OurGroup({
    required this.id,
    required this.name,
    required this.leader,
    required this.members,
    required this.groupCreated,
  });
}