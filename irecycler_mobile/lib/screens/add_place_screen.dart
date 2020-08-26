import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añade un nuevo punto de reciclaje'),
        backgroundColor: Colors.indigo[400],
      ),
      body: Center(
          child: Column(
        children: [
          Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://media-cdn.tripadvisor.com/media/photo-s/0b/71/10/23/hachiko.jpg'),
                      fit: BoxFit.fill))),
          RaisedButton.icon(
              onPressed: null,
              icon: Icon(Icons.add_a_photo),
              label: Text('Añadir imagen del lugar')),
          ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200, 50)),
            child: TextFormField(
              decoration:
                  InputDecoration(labelText: 'Nombre del punto de reciclaje'),
            ),
          ),
          Text('Ingreso de datos del usuario'),
          RaisedButton.icon(
            onPressed: null,
            icon: Icon(
              Icons.location_on,
              color: Colors.red[400],
            ),
            label: Text('Utilizar tu ubicación actual'),
          ),
        ],
      )),
    );
  }
}
