import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_diet/screens/setDiet/foodbank/food_search.dart';

class OpenMealPage extends StatelessWidget {
  String documentId, docDiet, docMeal;
  OpenMealPage(this.documentId, this.docDiet, this.docMeal, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alimentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('diet')
              .doc(documentId)
              .collection('diets')
              .doc(docDiet)
              .collection('meal')
              .doc(docMeal)
              .collection('aliment')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return Card(
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        doc.data()['description'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Kcal: ${doc.data()['kcal'].toString()}',
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp(documentId, docDiet, docMeal)));
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
