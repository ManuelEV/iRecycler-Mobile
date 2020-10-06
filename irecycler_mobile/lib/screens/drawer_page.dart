import 'package:flutter/material.dart';
import 'package:irecycler_mobile/auth/wrapper.dart';
import 'package:irecycler_mobile/screens/home.dart';
import 'package:irecycler_mobile/screens/my_points_screen.dart';
import 'package:irecycler_mobile/screens/points_on_map_screen.dart';
import 'package:irecycler_mobile/screens/select_point_map_screen.dart';
import 'package:irecycler_mobile/services/auth.dart';

import 'add_point_screen.dart';

class DrawerPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(context) {
    return Drawer(
        child: ListView(children: <Widget>[
      DrawerHeader(
          decoration: BoxDecoration(
              //color: Colors.pink[600],
              image: DecorationImage(
                  image: AssetImage('assets/images/drawer/exploracion.png'),
                  fit: BoxFit.cover)),
          child: Text('iRecycler',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
              ))),
      ListTile(
        title: Text('Home'),
        leading: Icon(Icons.home),
        onTap: () => Navigator.pushNamed(context, HomePage.routeName),
      ),
      ListTile(
        title: Text('Agregar punto'),
        leading: Icon(Icons.add_location),
        onTap: () => Navigator.pushNamed(context, AddPointScreen.routeName),
      ),
      ListTile(
        title: Text('Puntos en el mapa'),
        leading: Icon(Icons.map),
        onTap: () => Navigator.pushNamed(context, PointOnMapScreen.routeName),
      ),
      /*ListTile(
            title: Text('Puntos en el mapa'),
            leading: Icon(Icons.map),
            onTap: () => Navigator.pushNamed(context, PointOnMapScreen.routeName),
          ),*/
      ListTile(
        title: Text('Mis puntos'),
        leading: Icon(Icons.insert_chart),
        onTap: () => Navigator.pushNamed(context, MyPointsScreen.routeName),
      ),
      Divider(),
      ListTile(
        title: Text('Salir de iRecycler'),
        leading: Icon(Icons.logout, color: Colors.red),
        onTap: () async {
          Navigator.pushReplacementNamed(context, Wrapper.routeName);
          await _auth.signOut();
        },
      ),
      /* ListTile(
            title: Text('Salir'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.pushReplacementNamed(context, SalirPage.route) //NO SE PUEDE VOLVER ATRÁS
          )*/
    ]));
  }
}
