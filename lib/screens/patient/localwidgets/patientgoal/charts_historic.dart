import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCharts extends StatefulWidget {
  String documentId;
  HomeCharts(this.documentId, {Key? key}) : super(key: key);

  @override
  State<HomeCharts> createState() => _HomeChartsState();
}

class _HomeChartsState extends State<HomeCharts> {
  List<WeightData> _chartData = [];

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  List<WeightData> chartData = [];
  List<WeightData> getChartData() {
    FirebaseFirestore.instance
        .collection('patient')
        .doc(widget.documentId)
        .collection('weightUpdate')
        .orderBy('updateDate', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) => querySnapshot.docs.forEach(
              (doc) {
                chartData.add(WeightData(doc['weight'], doc['updateDate']));
              },
            ));
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('patient')
            .doc(widget.documentId)
            .collection('weightUpdate')
            .orderBy('updateDate', descending: true)
            .get()
            .then(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach(
                (doc) {
                  getChartData();
                },
              ),
            ),
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
            return SfCartesianChart(
              series: <ChartSeries>[
                LineSeries<WeightData, int>(
                    dataSource: _chartData,
                    xValueMapper: (WeightData data, _) => data.date,
                    yValueMapper: (WeightData data, _) => data.weight),
              ],
            );
          }
          return const Text('loading');
        });
  }
}

class WeightData {
  final int date;
  final double weight;

  WeightData(this.weight, this.date);
}
