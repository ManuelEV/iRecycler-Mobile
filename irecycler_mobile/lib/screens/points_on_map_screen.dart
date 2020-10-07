import 'package:flutter/material.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'package:irecycler_mobile/services/points_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'drawer_page.dart';

class PointOnMapScreen extends StatefulWidget {
  PointOnMapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: -38.73965, longitude: -72.59842),
  });

  static const routeName = '/points-on-map';
  final PlaceLocation initialLocation;

  @override
  _PointOnMapScreenState createState() => _PointOnMapScreenState();
}

class _PointOnMapScreenState extends State<PointOnMapScreen> {
  FirestoreService fS = FirestoreService();
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final pointsResults = await fS.getPlacesOnceOff();
    setState(() {
      _markers.clear();
      for (final point in pointsResults) {
        print('Punto X:' + point.toString());
        var marker = Marker(
          markerId: MarkerId(point.title),
          position: LatLng(point.location.latitude, point.location.longitude),
          infoWindow: InfoWindow(
            title: point.title,
            snippet: 'Capacidad disponible: ' + (100 - point.filled).toString(),
          ),
        );
        _markers[point.title] = marker;
        print('size:' + _markers.length.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis puntos'),
        actions: [],
      ),
      drawer: DrawerPage(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13,
        ),
        onMapCreated: _onMapCreated,
        //myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: _markers.values.toSet(),
      ),
    );
  }
}
