import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irecycler_mobile/screens/select_point_map_screen.dart';
import 'package:location/location.dart';
import 'package:irecycler_mobile/models/point.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double latitud;
  double longitud;

  //Obtener coordenadas de donde se encuentra el dispositivo
  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print('Latitud: ' + selectedLocation.latitude.toString());
    print('Longitud: ' + selectedLocation.longitude.toString());
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton.icon(
        icon: Icon(Icons.location_on),
        textColor: Colors.white,
        label: Text('Seleccionar ubicación'),
        onPressed: _selectOnMap,
        color: Colors.deepPurple[400],
      ),
    );
  }
}
