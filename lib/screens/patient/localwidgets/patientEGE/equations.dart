import 'package:app_diet/screens/patient/localwidgets/patientEGE/ege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Equations extends StatefulWidget {
  String chosenEquation, documentId, sex;
  double weight, height, age;
  Equations(this.chosenEquation, this.documentId, this.sex, this.weight,
      this.height, this.age,
      {Key? key})
      : super(key: key);

  @override
  State<Equations> createState() => _EquationsState();
}

class _EquationsState extends State<Equations> {
  var patient = FirebaseFirestore.instance.collection('pateint');
  String dropdownValue = 'Nível de atividade física';

  Future<void> updateBasal(double basal, String equation) async {
    FirebaseFirestore.instance
        .collection('patient')
        .doc(widget.documentId)
        .update({
      'basal': basal,
      'equation': equation,
      'totalCalorie': totalCalorie(basal),
      'exerciseLevel': dropdownValue
    });
  }

  Future<List> getPatientData() async {
    List lista = [];
    FirebaseFirestore.instance
        .collection('patient')
        .doc(widget.documentId)
        .get()
        .then((value) => {
              lista.add(value['weight']),
              lista.add(value['height']),
              lista.add(value['age']),
              lista.add(value['sex']),
            });
    return lista;
  }

  double harrisAndBenedictEquation(
    double height,
    double age,
    double weight,
    String sex,
  ) {
    double basal = 0;

    if (sex == 'M') {
      basal = 66.4730 + 13.7516 * weight + 5.0033 * height - 6.7550 * age;
    }
    if (sex == 'F') {
      basal = 655.0955 + 9.5634 * weight + 1.8496 * height - 4.6756 * age;
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal;
  }

  double schofieldEquation(
    double weight,
    double age,
    String sex,
  ) {
    double basal = 0;

    if (age >= 10 && age <= 17) {
      if (sex == 'M') {
        basal = 0.074 * weight + 2.754;
      }
      if (sex == 'F') {
        basal = 0.056 * weight + 2.898;
      }
    }
    if (age <= 29) {
      if (sex == 'M') {
        basal = 0.063 * weight + 2.896;
      }
      if (sex == 'F') {
        basal = 0.062 * weight + 2.036;
      }
    }
    if (age <= 59) {
      if (sex == 'M') {
        basal = 0.048 * weight + 2.653;
      }
      if (sex == 'F') {
        basal = 0.034 * weight + 2.538;
      }
    }
    if (age >= 60) {
      if (sex == 'M') {
        basal = 0.049 * weight + 2.459;
      }
      if (sex == 'F') {
        basal = 0.038 * weight + 2.755;
      }
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal * 239;
  }

  double whoEquation(
    double weight,
    double age,
    String sex,
  ) {
    double basal = 0;

    if (age >= 10 && age <= 17) {
      if (sex == 'M') {
        basal = 0.0732 * weight + 2.72;
      }
      if (sex == 'F') {
        basal = 0.0510 * weight + 3.12;
      }
    }
    if (age <= 29) {
      if (sex == 'M') {
        basal = 0.0640 * weight + 2.84;
      }
      if (sex == 'F') {
        basal = 0.0615 * weight + 2.08;
      }
    }
    if (age <= 59) {
      if (sex == 'M') {
        basal = 0.0485 * weight + 3.67;
      }
      if (sex == 'F') {
        basal = 0.0364 * weight + 3.47;
      }
    }
    if (age >= 60) {
      if (sex == 'M') {
        basal = 0.0565 * weight + 2.04;
      }
      if (sex == 'F') {
        basal = 0.0439 * weight + 2.49;
      }
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal * 239;
  }

  double henryAndReesEquation(
    double weight,
    double age,
    String sex,
  ) {
    double basal = 0;

    if (age >= 10 && age <= 17) {
      if (sex == 'M') {
        basal = 0.084 * weight + 2.122;
      }
      if (sex == 'F') {
        basal = 0.047 * weight + 2.951;
      }
    }
    if (age <= 29) {
      if (sex == 'M') {
        basal = 0.056 * weight + 2.80;
      }
      if (sex == 'F') {
        basal = 0.048 * weight + 2.562;
      }
    }
    if (age <= 59) {
      if (sex == 'M') {
        basal = 0.046 * weight + 3.160;
      }
      if (sex == 'F') {
        basal = 0.048 * weight + 2.448;
      }
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal * 239;
  }

  //fazer função abaixo
  double iretonJonesEquation(
    double weight,
    double age,
    String sex,
  ) {
    double basal = 0;

    if (age >= 10 && age <= 17) {
      if (sex == 'M') {
        basal = 0.0732 * weight + 2.72;
      }
      if (sex == 'F') {
        basal = 0.0510 * weight + 3.12;
      }
    }
    if (age <= 29) {
      if (sex == 'M') {
        basal = 0.0640 * weight + 2.84;
      }
      if (sex == 'F') {
        basal = 0.0615 * weight + 2.08;
      }
    }
    if (age <= 59) {
      if (sex == 'M') {
        basal = 0.0485 * weight + 3.67;
      }
      if (sex == 'F') {
        basal = 0.0364 * weight + 3.47;
      }
    }
    if (age >= 60) {
      if (sex == 'M') {
        basal = 0.0565 * weight + 2.04;
      }
      if (sex == 'F') {
        basal = 0.0439 * weight + 2.49;
      }
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal * 239;
  }

  double mifflinStJeorEquation(
    double height,
    double age,
    double weight,
    String sex,
  ) {
    double basal = 0;

    if (sex == 'M') {
      basal = 10 * weight + 6.25 * height - 5 * age + 5;
    }
    if (sex == 'F') {
      basal = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal;
  }

  double owenAndOwenEquation(
    double age,
    double weight,
    String sex,
  ) {
    double basal = 0;

    if (sex == 'M') {
      basal = 10.2 * weight + 875;
    }
    if (sex == 'F') {
      basal = 795 + 7.18 * weight;
    }

    basal = double.parse(basal.toStringAsPrecision(2));

    return basal;
  }

  double totalCalorie(double basal) {
    var total = 0.0;
    if (dropdownValue == 'Sedentario (pouca/nenhuma)') {
      total = basal * 1.2;
    }
    if (dropdownValue == 'Leve (1-3 dias/semana)') {
      total = basal * 1.375;
    }
    if (dropdownValue == 'Moderato (3-5 dias/semana)') {
      total = basal * 1.55;
    }
    if (dropdownValue == 'Muito Ativo (6-7 dias/semana)') {
      total = basal * 1.725;
    }
    if (dropdownValue == 'Muito Ativo & trabalho físico') {
      total = basal * 1.9;
    }

    total = double.parse(total.toStringAsPrecision(2));

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 40.0),
          child: Row(
            children: const [
              Text(
                'Caloria Basal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 40.0),
          child: Row(
            children: [
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
                    return Text(
                      '${data['basal']}',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    );
                  }
                  return const Text('loading');
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
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
              'Nível de atividade física',
              'Sedentario (pouca/nenhuma)',
              'Leve (1-3 dias/semana)',
              'Moderato (3-5 dias/semana)',
              'Muito Ativo (6-7 dias/semana)',
              'Muito Ativo & trabalho físico',
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
        Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 40.0),
          child: Row(
            children: const [
              Text(
                'Caloria Total',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 40.0),
          child: Row(
            children: [
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
                    return Text(
                      '${data['totalCalorie']}',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(16, 100, 255, 1)),
                    );
                  }
                  return const Text('loading');
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 56.0, left: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.chosenEquation == 'Harris and Benedict') {
                    updateBasal(
                        harrisAndBenedictEquation(widget.height, widget.age,
                            widget.weight, widget.sex),
                        widget.chosenEquation);
                  }
                  if (widget.chosenEquation == 'Schofield') {
                    updateBasal(
                        schofieldEquation(
                            widget.weight, widget.age, widget.sex),
                        widget.chosenEquation);
                  }
                  if (widget.chosenEquation == 'FAO/WHO/UNU') {
                    updateBasal(
                        whoEquation(widget.weight, widget.age, widget.sex),
                        widget.chosenEquation);
                  }
                  if (widget.chosenEquation == 'Henry and Rees') {
                    updateBasal(
                        henryAndReesEquation(
                            widget.weight, widget.age, widget.sex),
                        widget.chosenEquation);
                  }
                  if (widget.chosenEquation == 'Ireton-Jones') {
                    updateBasal(
                        iretonJonesEquation(
                            widget.weight, widget.age, widget.sex),
                        widget.chosenEquation);
                  }
                  if (widget.chosenEquation == 'Mifflin-St Jeor') {
                    updateBasal(
                        mifflinStJeorEquation(widget.height, widget.age,
                            widget.weight, widget.sex),
                        widget.chosenEquation);
                  }
                  if (widget.chosenEquation == 'Owen and Owen') {
                    updateBasal(
                        owenAndOwenEquation(
                            widget.weight, widget.age, widget.sex),
                        widget.chosenEquation);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(240, 12, 9, 30)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 64),
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
