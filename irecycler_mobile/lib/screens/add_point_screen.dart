import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'package:irecycler_mobile/models/user.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:irecycler_mobile/services/points_service.dart';
import 'package:irecycler_mobile/widgets/select_point_image.dart';
import 'package:irecycler_mobile/widgets/map_point_input.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;  

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
  String _uploadedFileURL;
  FirestoreService fS = FirestoreService();

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(longitude: lng, latitude: lat);
  }

  void _selectImage(File picture) {
    _pointImage = picture;
  }

  Future<void> _savePlace() async {
    if (_pointName.text.isEmpty ||
        _pointDescription.text.isEmpty ||
        _pointImage == null ||
        _pickedLocation == null) {
      return;
    }
    await uploadFile();
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    print(_uploadedFileURL);
    Place point = Place(
      description: _pointDescription.text,
      title: _pointName.text,
      location: _pickedLocation,
      image: _uploadedFileURL,
      userId: uid
    );
    point.filled = Random.secure().nextInt(100);
    await fS.addPlace(point);
    //Se guarda en firebase
    print(point.toMap());
    showDialog<void>(context: context, builder: (context) => myDialog());
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('points/${Path.basename(_pointImage.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_pointImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
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
              PointImage(_selectImage),
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
      child: RaisedButton.icon(
        icon: Icon(Icons.add_circle_sharp),
        color: Colors.pink[400],
        label: Text('Agregar punto'),
        textColor: Colors.white,
        onPressed: ()  {
          _savePlace();
        },
      ),
    );
  }

  Widget myDialog() {
    return AlertDialog(
      title: Text('Punto agregado exitosamente'),
      content:
          Text(''),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, AddPointScreen.routeName),
          child: Text('Aceptar'),
        )
      ],
    );
  }

}
