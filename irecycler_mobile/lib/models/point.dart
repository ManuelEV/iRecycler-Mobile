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

    return PlaceLocation(
        latitude: map['latitude'], longitude: map['longitude']);
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class Place {
  String id;
  final String title;
  final String description;
  int filled;
  final PlaceLocation location;
  final String image;
  final String documentId;
  String userId;

  Place(
      {this.id,
      @required this.description,
      @required this.title,
      this.filled,
      @required this.location,
      this.image,
      this.documentId,
      this.userId});

  Map<String, dynamic> toMap() {
    return {
      'placeId': id,
      'title': title,
      'image': image,
      'description': description,
      'filled': filled,
      'location': location.toMap(),
      'userId': userId
    };
  }

  static Place fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;
    return Place(
      title: map['title'],
      image: map['image'],
      description: map['description'],
      filled: map['filled'],
      location:
          PlaceLocation.fromMap(Map<String, dynamic>.from(map['location'])),
      id: map['placeId'],
      userId: map['userId'],
      documentId: documentId,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
