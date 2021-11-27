import 'package:app_diet/screens/patient/localwidgets/patientbody/popup.dart';
import 'package:app_diet/screens/patient/patient_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientBodyPage extends StatefulWidget {
  String documentId;
  PatientBodyPage(this.documentId, {Key? key}) : super(key: key);

  @override
  State<PatientBodyPage> createState() => _PatientBodyPageState();
}

class _PatientBodyPageState extends State<PatientBodyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 64.0),
        Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 40.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 30.0),
                onPressed: () {
 Navigator.of(context).pop();                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 40.0),
                child: Row(
                  children: const [
                    Text(
                      'Meu Corpo',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // First Row of square conteiners
              Padding(
                padding:
                    const EdgeInsets.only(top: 72.0, left: 40.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PopUp(context, 'weight', widget.documentId));
                      },
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(1, 22, 39, 10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('patient')
                                      .doc(widget.documentId)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    Map<String, dynamic> data = snapshot.data
                                        ?.data() as Map<String, dynamic>;
                                    if (snapshot.hasError) {
                                      return const Text('Something went wrong');
                                    }
                                    if (snapshot.hasData &&
                                        !snapshot.data!.exists) {
                                      return const Text(
                                          'Document does not exist');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Text(
                                        '${data['weight']}',
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      );
                                    }
                                    return const Text('loading');
                                  },
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'kg',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PopUp(context, 'height', widget.documentId));
                      },
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(255, 0, 34, 10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('patient')
                                      .doc(widget.documentId)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    Map<String, dynamic> data = snapshot.data
                                        ?.data() as Map<String, dynamic>;
                                    if (snapshot.hasError) {
                                      return const Text('Something went wrong');
                                    }
                                    if (snapshot.hasData &&
                                        !snapshot.data!.exists) {
                                      return const Text(
                                          'Document does not exist');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Text(
                                        '${data['height']}',
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      );
                                    }
                                    return const Text('loading');
                                  },
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'cm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Second Row of square conteiners
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PopUp(context, 'sex', widget.documentId));
                      },
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(16, 100, 255, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('patient')
                                      .doc(widget.documentId)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    Map<String, dynamic> data = snapshot.data
                                        ?.data() as Map<String, dynamic>;
                                    if (snapshot.hasError) {
                                      return const Text('Something went wrong');
                                    }
                                    if (snapshot.hasData &&
                                        !snapshot.data!.exists) {
                                      return const Text(
                                          'Document does not exist');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Text(
                                        '${data['sex']}',
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      );
                                    }
                                    return const Text('loading');
                                  },
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Sexo',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                PopUp(context, 'age', widget.documentId));
                      },
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(255, 115, 0, 10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('patient')
                                      .doc(widget.documentId)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    Map<String, dynamic> data = snapshot.data
                                        ?.data() as Map<String, dynamic>;
                                    if (snapshot.hasError) {
                                      return const Text('Something went wrong');
                                    }
                                    if (snapshot.hasData &&
                                        !snapshot.data!.exists) {
                                      return const Text(
                                          'Document does not exist');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Text(
                                        '${data['age']}',
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      );
                                    }
                                    return const Text('loading');
                                  },
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Idade',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
