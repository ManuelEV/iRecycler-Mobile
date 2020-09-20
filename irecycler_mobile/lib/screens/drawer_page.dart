import 'package:flutter/material.dart';
import 'package:irecycler_mobile/screens/home.dart';
import 'package:irecycler_mobile/screens/my_points_screen.dart';
import 'package:irecycler_mobile/screens/points_on_map_screen..dart';
import 'package:irecycler_mobile/screens/select_point_map_screen.dart';

import 'add_point_screen.dart';

class DrawerPage extends StatelessWidget{

  @override
  Widget build(context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              /*image: DecorationImage(
                image: AssetImage('assets/img/header.jpg'),
                fit: BoxFit.cover
              )*/
            ),
            child: Text(
              '',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
              )
              )
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.perm_contact_calendar),
            onTap: () => Navigator.pushNamed(context, HomePage.routeName),
          ),
          ListTile(
            title: Text('Agregar punto'),
            leading: Icon(Icons.perm_contact_calendar),
            onTap: () => Navigator.pushNamed(context, AddPointScreen.routeName),
          ),
          ListTile(
            title: Text('Mapa'),
            leading: Icon(Icons.view_agenda),
            onTap: () => Navigator.pushNamed(context, MapScreen.routeName),
          ),
          ListTile(
            title: Text('Puntos en el mapa'),
            leading: Icon(Icons.card_membership),
            onTap: () => Navigator.pushNamed(context, PointOnMapScreen.routeName),
          ),
          ListTile(
            title: Text('Mis puntos'),
            leading: Icon(Icons.card_membership),
            onTap: () => Navigator.pushNamed(context, MyPointsScreen.routeName),
          ),
          /* ListTile(
            title: Text('Salir'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.pushReplacementNamed(context, SalirPage.route) //NO SE PUEDE VOLVER ATRÁS
          )*/
        ]
      )
    );
  }

}