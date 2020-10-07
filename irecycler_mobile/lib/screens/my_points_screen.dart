import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:irecycler_mobile/models/user.dart';
import 'package:irecycler_mobile/screens/drawer_page.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:irecycler_mobile/services/points_service.dart';
import 'package:irecycler_mobile/widgets/graph_widget.dart';

class MyPointsScreen extends StatefulWidget {
  static const routeName = '/my_points';
  @override
  _MyPointsScreenState createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  FirestoreService fS = FirestoreService();
  List<Place> _points;

  List<charts.Series<LinearSales, String>> _createSampleData(int fill) {
    final data = [
      new LinearSales("Lleno", fill),
      new LinearSales("Vacio", 100 - fill),
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

  Future<List<Place>> getPointsData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    var placesByUser = await fS.getPlacesByUser(uid);
    return placesByUser;
  }

  @override
  void initState() {
    getPointsData().then((value) {
      setState(() {
        _points = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_points == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Mis puntos de reciclaje'),
          ),
          drawer: DrawerPage(),
          body: Text('No tiene puntos registrados'));
    }
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
        itemCount: this._points.length,
        itemBuilder: (context, index) {
          return Container(
            height: 500,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(this._points[index].title),
                  Container(
                    width: 300,
                    height: 400,
                    child: DonutAutoLabelChart(
                      this._createSampleData(_points[index].filled),
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
