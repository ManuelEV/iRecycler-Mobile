import 'package:flutter/material.dart';
import 'package:irecycler_mobile/screens/drawer_page.dart';
import 'package:irecycler_mobile/services/auth.dart';


class HomePage extends StatelessWidget{

  static String routeName = '/home-page';

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        appBar: AppBar(
          title: Text('iRecycler'),
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
        drawer: DrawerPage()
      );


  }

}