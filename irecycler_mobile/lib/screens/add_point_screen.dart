import 'package:flutter/material.dart';
import 'package:irecycler_mobile/widgets/select_point_image.dart';

class AddPointScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPointScreenState createState() => _AddPointScreenState();
}

class _AddPointScreenState extends State<AddPointScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añade un nuevo punto de reciclaje'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            PointImage(),
            _addPointName(),
            _addDescription(),
            _coordinatesBtn(),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            _keywords(),
          ],
        ),
      ),
    );
  }

  Widget _coordinatesBtn() {
    return RaisedButton.icon(
      icon: Icon(Icons.location_on),
      label: Text('Fijar ubicación'),
      onPressed: () {},
    );
  }

  Widget _addPointName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Nombre del lugar'),
        IconButton(
          visualDensity: VisualDensity.comfortable,
          icon: Icon(Icons.edit),
          tooltip: 'Nombre lugar',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _addDescription() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Descripción'),
        IconButton(
          visualDensity: VisualDensity.comfortable,
          icon: Icon(Icons.edit),
          tooltip: 'Nombre lugar',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _keywords() {
    return Container(
      child: Text('Keywords'),
    );
  }
}
