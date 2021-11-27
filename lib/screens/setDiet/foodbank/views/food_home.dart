import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:app_diet/models/food_model.dart';


class OurHome extends StatefulWidget {
  const OurHome({Key? key}) : super(key: key);

  @override
  _OurHomeState createState() => _OurHomeState();
}

class _OurHomeState extends State<OurHome> {
  List<FoodModel> foodModel = <FoodModel>[];

  getAlimentoIdFromSheet() async {
    try {
      var raw = await http.get(Uri.parse(
          "https://script.google.com/macros/s/AKfycbzNUS-18xFW2Jo-RFdGFB85ZZRT9NvrL5F4qbfQ7dain4_kJ-aSc1KrRsuYwo1XdGwa/exec"));
      var jsonFood = convert.jsonDecode(raw.body);
      print('this is json food: $jsonFood');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alimentos"),
        elevation: 0,
      ),
      body: Container(
        child: ElevatedButton(
          child: Text("Teste"),
          onPressed: () => getAlimentoIdFromSheet(),
        ),
      ),
    );
  }
}

class OurFoodTile extends StatelessWidget {
  String alimentoId, descricao, kcal, proteina, lipidio, carboidrato;

  OurFoodTile(
      {required this.alimentoId,
      required this.descricao,
      required this.kcal,
      required this.proteina,
      required this.lipidio,
      required this.carboidrato});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
