import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  int mealNumber;
  CarouselWidget(this.mealNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lista = [1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 32, left: 40, bottom: 24),
          child: Text(
            'Refeição',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(height: 300.0),
          items: lista.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 0, 34, 10),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        'Alimento $i',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
