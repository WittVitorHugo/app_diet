import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:app_diet/models/food_model.dart';

class MyApp extends StatelessWidget {
  String documentId, docDiet, docMeal;

  MyApp(this.documentId, this.docDiet, this.docMeal, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodSearchPage(documentId, docDiet, docMeal),
    );
  }
}

class FoodSearchPage extends StatefulWidget {
  String documentId, docDiet, docMeal;
  FoodSearchPage(this.documentId, this.docDiet, this.docMeal, {Key? key})
      : super(key: key);

  @override
  _FoodSearchPageState createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  List<FoodModel> _foods = <FoodModel>[];
  List<FoodModel> _foodsForDisplay = <FoodModel>[];

  Future fetchFood() async {
    var url = 'https://sheetdb.io/api/v1/choc5crewo4wu';
    var response = await http.get(Uri.parse(url));

    var foods = <FoodModel>[];

    if (response.statusCode == 200) {
      var foodsJson = json.decode(response.body);
      for (var foodJson in foodsJson) {
        foods.add(FoodModel.fromJson(foodJson));
      }
    }
    return foods;
  }

  @override
  void initState() {
    fetchFood().then((value) {
      setState(() {
        _foods.addAll(value);
        _foodsForDisplay = _foods;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisar alimentos"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return index == 0 ? _searchBar() : _listItem(index - 1);
        },
        itemCount: _foodsForDisplay.length + 1,
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(hintText: 'Pesquisar alimento...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _foodsForDisplay = _foods.where((food) {
              var foodTitle = food.descricao.toLowerCase();
              return foodTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(
                context,
                widget.documentId,
                widget.docDiet,
                widget.docMeal,
                _foodsForDisplay[index].descricao,
                _foodsForDisplay[index].kcal,
                _foodsForDisplay[index].proteina,
                _foodsForDisplay[index].lipidio,
                _foodsForDisplay[index].carboidrato));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 24.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      child: Text(
                        _foodsForDisplay[index].descricao,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      width: 175,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Peso: 100g',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kcal: ${_foodsForDisplay[index].kcal}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Proteina: ${_foodsForDisplay[index].proteina}'),
                  Text('Lipidio: ${_foodsForDisplay[index].lipidio}'),
                  Text('Carboidrato: ${_foodsForDisplay[index].carboidrato}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, documentId, docDiet, docMeal,
    String aliment, String kcal, String prot, String lipi, String carb) {
  TextEditingController _pesoController = TextEditingController();
  _pesoController.text = '100';

  void addFood(String desc, double kcal, double grams) {
    FirebaseFirestore.instance
        .collection('diet')
        .doc(documentId)
        .collection('diets')
        .doc(docDiet)
        .collection('meal')
        .doc(docMeal)
        .collection('aliment')
        .doc()
        .set({'description': desc, 'kcal': kcal, 'grams': grams});
  }

  double convertNumber(String n, double g) {
    var res = n.replaceAll(',', '.');

    double calc = double.parse(res) * g / 100;
    return calc;
  }

  return AlertDialog(
    title: Text(aliment),
    content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Proteína: ${convertNumber(prot, double.parse(_pesoController.text))}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Lipidios: ${convertNumber(lipi, double.parse(_pesoController.text))}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Carboidrato: ${convertNumber(carb, double.parse(_pesoController.text))}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Text(
                'Quilocaloria: ${convertNumber(kcal, double.parse(_pesoController.text))}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
              const SizedBox(height: 32),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _pesoController,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 18.0),
                    labelText: 'Peso em gramas',
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
            ],
          ),
        ]),
    actions: [
      TextButton(
        onPressed: () {
          addFood(
              aliment,
              convertNumber(kcal, double.parse(_pesoController.text)),
              double.parse(_pesoController.text));
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: const Text(
          'Adicionar',
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
