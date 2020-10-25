import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sightseeing/helpers/db.dart';
import 'package:sightseeing/helpers/maps.dart';

class Location {
  final String address;
  final double longtitude;
  final double latitude;

  Location({
    this.address,
    @required this.longtitude,
    @required this.latitude,
  });
}

class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}

class Places with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  int get placeCount {
    return _items.length;
  }

  Future<void> addPlace({
    @required String title,
    @required File image,
    @required Location location,
  }) async {
    final address = await GMapsHelper.getAddress(
      latitude: location.latitude,
      longtitude: location.longtitude,
    );
    location = Location(
      latitude: location.latitude,
      longtitude: location.longtitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: location);
    _items.add(newPlace);
    DB.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longtitude': newPlace.location.longtitude,
      'address': newPlace.location.address,
    });
    notifyListeners();
  }

  Place getPlace(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> fetchAndSet() async {
    final data = await DB.fetchData('places');
    _items = data
        .map((p) => Place(
              id: p['id'],
              title: p['title'],
              image: File(p['image']),
              location: Location(
                address: p['address'],
                latitude: p['latitude'],
                longtitude: p['longtitude'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
