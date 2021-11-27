import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:app_diet/screens/root/root.dart';
import 'package:app_diet/states/current_user.dart';
import 'localwidgets/patientEGE/ege.dart';
import 'localwidgets/patientbody/patient_body.dart';
import 'localwidgets/patientgoal2/patient_goal.dart';

class PatientProfilePage extends StatelessWidget {
  String documentId;
  PatientProfilePage(this.documentId, {Key? key}) : super(key: key);

  var user = FirebaseAuth.instance.currentUser;

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OurRoot()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 64.0),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 40.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 30.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                    child: Container(
                      height: 130,
                      width: 130,
                      child: const Text(
                        '',
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage('assets/ee.jpg'),
                          )),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 40.0),
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          Map<String, dynamic> data =
                              snapshot.data?.data() as Map<String, dynamic>;
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const Text('Document does not exist');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text(
                              '${data['fullName']}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'roboto',
                              ),
                            );
                          }
                          return const Text('loading');
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 40.0, right: 32.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.person_rounded,
                          size: 40,
                        ),
                      ),
                      const Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Meu Corpo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PatientBodyPage(user.uid)));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 40.0, right: 32.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.adjust,
                          size: 40,
                        ),
                      ),
                      const Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Text(
                            'Meu objetivo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PatientGoalPage(user.uid)));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 40.0, right: 32.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.bar_chart_outlined,
                          size: 40,
                        ),
                      ),
                      const Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Text(
                            'Gasto Energético',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EGEPage(documentId)));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 72.0, left: 32.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          _signOut(context);
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
