import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:irecycler_mobile/services/points_service.dart';
import 'drawer_page.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: -38.73965, longitude: -72.59842),
      this.isSelecting = true});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  FirestoreService fS = FirestoreService();
  final Map<String, Marker> _markers = {};

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final pointsResults = await fS.getPlacesOnceOff();
    setState(() {
      _markers.clear();
      for (final point in pointsResults) {
        var marker = Marker(
          markerId: MarkerId(point.title),
          position: LatLng(point.location.latitude, point.location.longitude),
          infoWindow: InfoWindow(
            title: point.title,
            snippet: 'Capacidad disponible: ' + (100 - point.filled).toString(),
          ),
        );
        _markers[point.title] = marker;
      }
    });
  }

  Map<String, Marker> _addMarker() {
    setState(() {
      _markers['New Marker'] =
          Marker(markerId: MarkerId('m1'), position: _pickedLocation);
    });
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        elevation: 0.0,
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () => {Navigator.of(context).pop(_pickedLocation)},
            ),
        ],
      ),
      drawer: DrawerPage(),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 13,
          ),
          //myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickedLocation == null
              ? _markers.values.toSet()
              : _addMarker().values.toSet()),
    );
  }
}
