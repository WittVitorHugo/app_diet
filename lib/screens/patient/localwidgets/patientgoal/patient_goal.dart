import 'package:app_diet/screens/patient/localwidgets/patientgoal/charts_historic.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/patient/localwidgets/patientgoal/popup.dart';

class PatientGoalPage extends StatefulWidget {
  String documentId;
  PatientGoalPage(this.documentId, {Key? key}) : super(key: key);

  @override
  State<PatientGoalPage> createState() => _PatientGoalPageState();
}

class _PatientGoalPageState extends State<PatientGoalPage> {
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
                    Navigator.of(context).pop();
                  },
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
                        'Meu Objetivo',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
                                        return const Text(
                                            'Something went wrong');
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
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Peso atual',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => PopUp(
                                  context, 'goalWeight', widget.documentId));
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
                                        return const Text(
                                            'Something went wrong');
                                      }
                                      if (snapshot.hasData &&
                                          !snapshot.data!.exists) {
                                        return const Text(
                                            'Document does not exist');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Text(
                                          '${data['goalWeight']}',
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
                                    'kg',
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
                                    'Meta de peso',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                HomeCharts(widget.documentId)
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
