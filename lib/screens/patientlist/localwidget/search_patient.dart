import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/patientlist/localwidget/add_patient.dart';

class SearchPatientPage extends StatefulWidget {
  const SearchPatientPage({Key? key}) : super(key: key);

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final listaEmail = [];
  final listaName = [];
  final listaUid = [];
  late String uid;

  Future<void> searchPatient() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('groupId', isEqualTo: 'paciente')
        .get()
        .then(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                  listaEmail.add(doc['email']);
                  listaName.add(doc['fullName']);
                  listaUid.add(doc['uid']);
                }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procurar paciente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Nome do paciente'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email do paciente'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text(
                'Procurar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                searchPatient();
                for (var i = 0; i < listaName.length; i++) {
                  if (listaName[i] == _nameController.text &&
                      listaEmail[i] == _emailController.text) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPatientPage(
                          listaUid[i],
                          listaEmail[i],
                          listaName[i],
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
