import 'package:app_diet/states/current_user.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/home/localwidget/home_nutri.dart';
import 'package:app_diet/screens/home/localwidget/home_user.dart';
import 'package:app_diet/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = FirebaseAuth.instance.currentUser;

    Future<void> createCollectionPatient() async {
      FirebaseFirestore.instance.collection('patient').doc(user.uid).set({
        'patientId': user.uid,
        'weight': 0.0,
        'height': 0.0,
        'age': 0.0,
        'sex': '-',
        'goalWeight': 0.0,
        'basal': 0.0,
        'equation': '',
        'exerciseLevel': '',
        'totalCalorie': 0.0,
      });
    }

    return Scaffold(
      bottomNavigationBar: const OurNavigationBar(),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user.uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Map<String, dynamic> data =
              snapshot.data?.data() as Map<String, dynamic>;
          firestore.collection('patient').doc(user.uid).get().then(
              (DocumentSnapshot snapshot) =>
                  {snapshot.exists ? null : createCollectionPatient()});
          //create and "update" field uid with documentId value of current user when the first loggin is done
          firestore.collection('users').doc(user.uid).update({'uid': user.uid});

          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (data == null) {
            return const Text('Document is null');
          }
          if (data['groupId'] == 'nutricionista') {
            return HomeScreenNutri();
          }
          return HomeScreenUser();
        },
      ),
    );
  }
}
