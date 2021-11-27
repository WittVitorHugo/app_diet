import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_diet/screens/patientlist/patient_list.dart';

class HomeScreenNutri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 48.0, bottom: 16.0, left: 24.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 80.0,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientList()));
              },
              child: Container(
                height: 72,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(16, 100, 255, 1),
                ),
                child: const Center(
                  child: Text(
                    'Lista de pacientes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
