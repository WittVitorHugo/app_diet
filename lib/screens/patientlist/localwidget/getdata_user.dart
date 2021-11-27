import 'package:app_diet/screens/patientlist/patient_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class GetDataUser extends StatelessWidget {
  String patientId;
  String patientEmail;
  String patientName;

  GetDataUser(this.patientId, this.patientEmail, this.patientName, {Key? key}) : super(key: key);

  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final databaseReference = FirebaseFirestore.instance;
    Future<void> addPatient() async {
      databaseReference
          .collection('users')
          .doc(currentUser.uid)
          .collection('patient')
          .doc(patientId)
          .set({'patientId': patientId, 'email': patientEmail, 'patientName': patientName});
    }

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(patientId).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Map<String, dynamic> data =
            snapshot.data?.data() as Map<String, dynamic>;
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/square.png'),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Nome Completo'),
                      Text(
                        '${data['fullName']}',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Email'),
                      Text(
                        '${data['email']}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Tipo de conta'),
                      Text(
                        '${data['groupId']}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Adicionar Paciente',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          addPatient();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientList()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        }
        return const Text('loading');
      },
    );
  }
}
