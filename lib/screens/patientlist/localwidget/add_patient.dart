import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'getdata_user.dart';

class AddPatientPage extends StatelessWidget {
  String patientId;
  String patientEmail;
  String patientName;
  AddPatientPage(this.patientId, this.patientEmail, this.patientName, {Key? key}) : super(key: key);

  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Paciente'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              GetDataUser(patientId, patientEmail, patientName),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
