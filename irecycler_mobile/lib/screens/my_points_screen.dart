import 'package:flutter/material.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:irecycler_mobile/screens/drawer_page.dart';
import 'package:irecycler_mobile/widgets/graph_widget.dart';

class MyPointsScreen extends StatefulWidget {
  static const routeName = '/my_points';
  @override
  _MyPointsScreenState createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales("Lleno", 75),
      new LinearSales("Vacio", 25),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.estado,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.estado}: ${row.sales}',
      )
    ];
  }

  final List<Place> points = [
    Place(
      id: '1',
      title: 'Punto 1',
      description: 'adsdasdasd',
      location: PlaceLocation(longitude: 3.123, latitude: 22.33),
      filled: 50,
    ),
    Place(
      id: '2',
      title: 'Punto 2',
      filled: 75,
      description: 'adsdasdasd',
      location: PlaceLocation(longitude: 3.123, latitude: 22.33),
    ),
    Place(
        id: '3',
        title: 'Punto 3',
        filled: 89,
        description: 'adsdasdasd',
        location: PlaceLocation(longitude: 3.123, latitude: 22.33)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            items: <String>['1 Mes', '6 Meses', '1 Año', '5 Años']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {});
            },
          )
        ],
        title: Text('Mis puntos de reciclaje'),
      ),
      drawer: DrawerPage(),
      body: ListView.builder(
        itemCount: this.points.length,
        itemBuilder: (context, index) {
          return Container(
            height: 500,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(this.points[index].title),
                  Container(
                    width: 300,
                    height: 400,
                    child: DonutAutoLabelChart(
                      this._createSampleData(),
                      animate: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final String estado;
  final int sales;

  LinearSales(this.estado, this.sales);
}
