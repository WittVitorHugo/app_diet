import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/patient/patient_profile.dart';
import 'package:app_diet/screens/patientlist/localwidget/search_patient.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  var user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pacientes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('users')
            .doc(user.uid)
            .collection('patient')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      String patientId = doc.data()['patientId'];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientProfilePage(patientId)));
                    },
                    title: Text(
                      doc.data()['patientName'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchPatientPage()));
          },
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
