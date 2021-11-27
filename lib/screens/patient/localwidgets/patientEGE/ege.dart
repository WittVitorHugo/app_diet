import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/patient/localwidgets/patientEGE/equations.dart';

class EGEPage extends StatefulWidget {
  String documentId;
  EGEPage(this.documentId, {Key? key}) : super(key: key);

  @override
  State<EGEPage> createState() => _EGEPageState();
}

class _EGEPageState extends State<EGEPage> {
  String dropdownValue = 'Escolher equação';

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
                        'Gasto Calórico',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    children: [
                      Center(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 35,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'Escolher equação',
                            'Harris and Benedict',
                            'Schofield',
                            'FAO/WHO/UNU',
                            'Henry and Rees',
                            'Ireton-Jones',
                            'Mifflin-St Jeor',
                            'Owen and Owen'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('patient')
                      .doc(widget.documentId)
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Map<String, dynamic> data =
                        snapshot.data?.data() as Map<String, dynamic>;
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text('Document does not exist');
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Equations(
                        dropdownValue,
                        widget.documentId,
                        data['sex'],
                        double.parse(data['weight']),
                        double.parse(data['height']),
                        double.parse(data['age']),
                      );
                    }
                    return const Text('loading');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
