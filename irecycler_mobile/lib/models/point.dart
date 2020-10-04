import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double longitude;
  final double latitude;

  const PlaceLocation({@required this.longitude, @required this.latitude});
}

class Place {
  final String id;
  final String title;
  final String description;
  final int filled;
  final PlaceLocation location;
  final File image;
  final String documentId;


  Place(
      {@required this.id,
      @required this.description,
      @required this.title,
      @required this.filled,
      @required this.location,
      @required this.image,
      @required this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'placeId': id,
      'title': title,
      'imageUrl': image,
      'description':description,
      'filled':filled,
      'location':location,
    };
  }

  static Place fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Place(
      title: map['title'],
      image: map['imageUrl'],
      description: map['description'],
      filled: map['filled'],
      location: map['location'],
      id: map['placeId'],
      documentId: documentId,
    );
  }
  
}
