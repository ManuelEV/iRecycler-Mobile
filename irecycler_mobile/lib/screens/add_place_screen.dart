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
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _placeImage(),
            addPlaceImage(),
            _addPlacementName(),
            _coordinates_btn(),
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

  Widget _placeImage() {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(
                'https://media-cdn.tripadvisor.com/media/photo-s/0b/71/10/23/hachiko.jpg'),
            fit: BoxFit.fill),
      ),
    );
  }

  Widget addPlaceImage() {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton.icon(
        onPressed: null,
        icon: Icon(Icons.add_a_photo),
        label: Text('Picture'),
      ),
    );
  }

  Widget _coordinates_btn() {
    return RaisedButton(
      child: Text('Coordenadas'),
      onPressed: () {},
    );
  }

  Widget _addPlacementName() {
    return Row(
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

  Widget _keywords() {
    return Container(
      child: Text('Keywords'),
    );
  }
}
