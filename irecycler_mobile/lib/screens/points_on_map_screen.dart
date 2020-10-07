import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Map<String, Marker> _markers = {};
  String dropdownValue = 'Todos';
  List pointsResults;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    pointsResults = await fS.getPlacesOnceOff();
    _setMarkers(showAll: true);
  }

  Future<String> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    return uid;
  }

  void _setMarkers({bool showAll}) async {
    String userId = await getUser();
    List points = pointsResults;
    setState(() {
      _markers.clear();
      if (!showAll) {
        print(userId);
        points =
            pointsResults.where((element) => element.userId == userId).toList();
      }
      for (final point in points) {
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
      print(_markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis puntos'),
        actions: [
          _showDropDown(),
        ],
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

  Widget _showDropDown() {
    return DropdownButton<String>(
      value: dropdownValue,
      iconEnabledColor: Colors.white,
      dropdownColor: Colors.teal[300],
      iconSize: 24,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          if (dropdownValue == 'Todos') {
            _setMarkers(showAll: true);
          } else {
            _setMarkers(showAll: false);
          }
        });
      },
      items: <String>['Todos', 'Mis puntos']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
    );
  }
}
