import 'package:flutter/material.dart';
import 'package:irecycler_mobile/screens/select_point_map_screen.dart';
import 'package:irecycler_mobile/widgets/select_point_image.dart';
import 'package:irecycler_mobile/widgets/map_point_input.dart';

class AddPointScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPointScreenState createState() => _AddPointScreenState();
}

class _AddPointScreenState extends State<AddPointScreen> {
  TextEditingController _pointName = TextEditingController();
  TextEditingController _pointDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añade un nuevo punto de reciclaje'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PointImage(),
              _addPointName(),
              _addDescription(),
              _showMapBtn(context),
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

  Widget _showMapBtn(context) {
    return RaisedButton.icon(
      icon: Icon(Icons.location_on),
      label: Text('Seleccionar ubicación'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
      },
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
      child: Text('Keywords'),
    );
  }

  Widget _savePoint() {
    return Container(
      child: RaisedButton(
        color: Colors.green,
        child: Text('Agregar punto'),
        onPressed: () => {},
      ),
    );
  }
}
