import 'package:flutter/material.dart';
import 'package:irecycler_mobile/screens/drawer_page.dart';
import 'package:irecycler_mobile/services/auth.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('iRecycler'), elevation: 0.0),
        drawer: DrawerPage(),
        bottomSheet: Image(
            image: AssetImage('assets/images/home/home-footer.png'),
            height: 250.0,
            fit: BoxFit.cover
            
        ),
        body: ListView(
            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: <Widget>[
              _bodyContent(),
            ]));
  }

  Widget _bodyContent() {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/home/home-header.png'),
          height: 250.0,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text('Bienvenid@ a iRecycler'),
        ),
        /*Image(
            image: AssetImage('assets/images/home/home-footer.png'),
            height: 250.0,
            fit: BoxFit.cover
            
        ),*/
        
      
      ],
    );
  }
}
