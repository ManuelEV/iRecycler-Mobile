import 'dart:math';

import 'package:flutter/material.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:irecycler_mobile/services/points_service.dart';
import 'package:irecycler_mobile/widgets/select_point_image.dart';
import 'package:irecycler_mobile/widgets/map_point_input.dart';
import 'dart:io';

import 'drawer_page.dart';

class AddPointScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPointScreenState createState() => _AddPointScreenState();
}

class _AddPointScreenState extends State<AddPointScreen> {
  TextEditingController _pointName = TextEditingController();
  TextEditingController _pointDescription = TextEditingController();

  PlaceLocation _pickedLocation;
  File _pointImage;
  FirestoreService fS = FirestoreService();


  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(longitude: lng, latitude: lat);
  }

  void _savePlace() {
    
    if (_pointName.text.isEmpty ||
        _pointDescription.text.isEmpty ||
        //_pointImage == null ||
        _pickedLocation == null) {
      return;
    }
    print('toma datos');
    Place point = Place(description: _pointDescription.text, title: _pointName.text, location: _pickedLocation, 
    //image: _pointImage
    );
    point.filled = Random.secure().nextInt(100);
    print(point.toMap());
    fS.addPlace(point);
    //Guardar en firebase?
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añade un nuevo punto de reciclaje'),
        elevation: 0.0,
        actions: <Widget>[
          /*  FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ) */
        ],
      ),
      drawer: DrawerPage(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PointImage(),
              _addPointName(),
              _addDescription(),
              LocationInput(_selectPlace),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              _keywords(),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              _savePoint(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addPointName() {
    return Container(
      width: 200,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: _pointName,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit),
          hintText: 'Nombre del punto',
        ),
      ),
    );
  }

  Widget _addDescription() {
    return Container(
      margin: EdgeInsets.all(5),
      width: 200,
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: _pointDescription,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit),
          hintText: 'Descripción ...',
        ),
      ),
    );
  }

  Widget _keywords() {
    return Container(
      width: 400,
      height: 75,
      child: GridView(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2,
            crossAxisCount: 5,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        children: [
          Card(
            child: Text('Ufro'),
          ),
          Card(
            child: Text('Temuco'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag2'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag2'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag2'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag2'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          Card(
            child: Text('Tag1'),
          ),
          FloatingActionButton(
            onPressed: null,
            elevation: 0,
            isExtended: true,
            backgroundColor: Colors.purple[300],
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Widget _savePoint() {
    return Container(
      child: RaisedButton(
        color: Colors.indigo,
        child: Text('Agregar punto'),
        textColor: Colors.white,
        onPressed: () => {_savePlace()},
      ),
    );
  }
}
