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
  List<Place> _points;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future fetchPoints() async {
    var pointsResults = await fS.getPlacesOnceOff();
    print(pointsResults);
    if (pointsResults is List<Place>) {
      _points = pointsResults;
      //notifyListeners();
    } else {
      print('error');
    }
  }

  populateMap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puntos en el mapa'),
        elevation: 0.0,
        actions: [
          FloatingActionButton(
            onPressed: () => {fetchPoints(), print(_points)},
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
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {},
        onTap: null,
      ),
    );
  }
}
/*  void _getPoint(){
    var points = fS.getPlacesOnceOff();
    if(docs.documents.isNotEmpty){
      for(int i= 0; i < docs.documents.length; i++) {
        initMarker(docs.documents[i].data, docs.documents[i].documentID);
      }
    }} */
