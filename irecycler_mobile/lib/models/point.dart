import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double longitude;
  final double latitude;

  const PlaceLocation({@required this.longitude, @required this.latitude});
  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  static PlaceLocation fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PlaceLocation(latitude: map['latitude'],longitude: map['longitude']
    );
  }
}

class Place {
  String id;
  final String title;
  final String description;
  int filled;
  final PlaceLocation location;
  final File image;
  final String documentId;

  Place(
      {this.id,
      @required this.description,
      @required this.title,
      this.filled,
      @required this.location,
      this.image,
      this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'placeId': id,
      'title': title,
      'image': image,
      'description': description,
      'filled': filled,
      'location': location.toMap(),
    };
  }

  static Place fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Place(
      title: map['title'],
      image: map['image'],
      description: map['description'],
      filled: map['filled'],
      location: map['location'],
      id: map['placeId'],
      documentId: documentId,
    );
  }
}
