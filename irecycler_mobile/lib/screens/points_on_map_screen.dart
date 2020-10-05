import 'package:flutter/material.dart';
import 'package:irecycler_mobile/services/auth.dart';

import 'drawer_page.dart';

class PointOnMapScreen extends StatelessWidget {
  static const routeName = '/points-on-map';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lugares agregados"),
        elevation: 0.0
      ),
      drawer: DrawerPage(),
      //TODO: agregar el mapa de puntos
    );
  }
}
