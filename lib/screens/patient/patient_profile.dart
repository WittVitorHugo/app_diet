import 'package:app_diet/screens/patient/localwidgets/patientEGE/ege.dart';
import 'package:app_diet/screens/patient/localwidgets/patientbody/patient_body.dart';
import 'package:app_diet/screens/patient/localwidgets/patientgoal/patient_goal.dart';
import 'package:app_diet/screens/patientlist/patient_list.dart';
import 'package:app_diet/screens/setDiet/setdiet.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientProfilePage extends StatefulWidget {
  String documentId;
  PatientProfilePage(this.documentId, {Key? key}) : super(key: key);

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  var user = FirebaseAuth.instance.currentUser;

  List str = [];
  var usersCollection = FirebaseFirestore.instance.collection('users');

  void addDiet() {
    FirebaseFirestore.instance.collection('diet').doc(widget.documentId).set({
      'patientId': widget.documentId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 64.0),
          Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
              left: 40.0,
              right: 40,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 30.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, user.uid, widget.documentId));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromRGBO(240, 12, 9, 30),
                      size: 30,
                    ),
                  ),
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
                        future: usersCollection
                            .doc(user.uid)
                            .collection('patient')
                            .doc(widget.documentId)
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
                              '${data['patientName']}',
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
                                          PatientBodyPage(widget.documentId)));
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
                          Icons.circle_outlined,
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
                                          PatientGoalPage(widget.documentId)));
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
                                      builder: (context) => EGEPage(
                                            widget.documentId,
                                          )));
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          addDiet();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SetDietPage(widget.documentId)));
                        },
                        child: Container(
                          width: 215,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(16, 100, 255, 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 24.0,
                              bottom: 8.0,
                              right: 8.0,
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.food_bank,
                                  size: 35,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Montar Dieta',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
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

Widget _buildPopupDialog(BuildContext context, String uid, String docuemtnId) {
  return AlertDialog(
    title: const Text('Excluir paciente'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Tem certeza que deseja excluir este paciente?'),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('patient')
              .doc(docuemtnId)
              .delete();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PatientList()));
        },
        child: const Text(
          'Sim',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.grey),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          'Cancelar',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(240, 12, 9, 30)),
        ),
      ),
    ],
  );
}
