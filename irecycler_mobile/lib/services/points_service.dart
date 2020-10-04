import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irecycler_mobile/models/point.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _pointsCollectionReference =
      Firestore.instance.collection('points');

  final StreamController<List<Place>> _pointsController =
      StreamController<List<Place>>.broadcast();

  Future addPlace(Place point) async {
    try {
      await _pointsCollectionReference.add(point.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPlacesOnceOff() async {
    try {
      var pointDocumentSnapshot = await _pointsCollectionReference.getDocuments();
      if (pointDocumentSnapshot.documents.isNotEmpty) {
        return pointDocumentSnapshot.documents
            .map((snapshot) => Place.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToPlacesRealTime() {
    // Register the handler for when the points data changes
    _pointsCollectionReference.snapshots().listen((pointsSnapshot) {
      if (pointsSnapshot.documents.isNotEmpty) {
        var points = pointsSnapshot.documents
            .map((snapshot) => Place.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the points onto the controller
        _pointsController.add(points);
      }
    });

    return _pointsController.stream;
  }

  Future deletePlace(String documentId) async {
    await _pointsCollectionReference.document(documentId).delete();
  }

  Future updatePlace(Place point) async {
    try {
      await _pointsCollectionReference
          .document(point.documentId)
          .updateData(point.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}