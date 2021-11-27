import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/setDiet/localwidget/open_diet.dart';

class SetDietPage extends StatelessWidget {
  String documentId;
  SetDietPage(this.documentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dietas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('diet')
            .doc(documentId)
            .collection('diets')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OpenDietPage(documentId, doc.id)));
                    },
                    title: Text(
                      doc.data()['nameDiet'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      doc.data()['description'],
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, documentId));
          },
          child: const Icon(
            Icons.add,
            size: 35,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String documentId) {
  TextEditingController _nameDietController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void addDiet(String name, String desc) {
    FirebaseFirestore.instance
        .collection('diet')
        .doc(documentId)
        .collection('diets')
        .doc()
        .set({
      'nameDiet': name,
      'description': desc,
      'mealNumber': 0,
    });
  }

  return AlertDialog(
    title: const Text('Adicionar dieta'),
    content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameDietController,
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 18.0),
                labelText: 'Nome da Dieta',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0))),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 3,
            controller: _descriptionController,
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 18.0),
                labelText: 'Descrição da Dieta',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0))),
            style: const TextStyle(color: Colors.black),
          ),
        ]),
    actions: [
      TextButton(
        onPressed: () {
          addDiet(_nameDietController.text, _descriptionController.text);
          Navigator.of(context).pop();
        },
        child: const Text(
          'Criar',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(240, 12, 9, 30)),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          'Cancelar',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.grey),
        ),
      ),
    ],
  );
}
