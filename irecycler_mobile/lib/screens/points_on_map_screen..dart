import 'package:flutter/material.dart';
import 'package:irecycler_mobile/services/auth.dart';

class PointOnMapScreen extends StatelessWidget {
  static const routeName = '/points-on-map';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lugares agregados"),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
