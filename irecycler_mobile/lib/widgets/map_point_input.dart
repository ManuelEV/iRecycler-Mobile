import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double latitud;
  double longitud;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione en mapa'),
      ),
      body: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        child: Icon(
          Icons.gps_fixed,
          color: Colors.black,
        ),
        onPressed: _getCurrentLocation,
      ),
    );
  }
}
