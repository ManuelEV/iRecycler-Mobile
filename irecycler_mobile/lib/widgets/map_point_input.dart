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
    return Container(
      child: FlatButton.icon(
        label: Text('sadasd'),
        onPressed: _getCurrentLocation,
        icon: Icon(Icons.headset),
      ),
    );
  }
}
