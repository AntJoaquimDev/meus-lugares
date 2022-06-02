// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place/models/place.dart';
import 'package:great_place/utils/db_util.dart';
import 'package:great_place/utils/location_util.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  var index;

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');

    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            date: DateTime.parse(item['date']),
            //date: item['date'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Place get(itemByIndex) {
    return _items[index];
  }

  notifyListeners();

  Future<void> addPlace(
    String title,
    DateTime date,
    File image,
    LatLng position,
  ) async {
    final date = DateTime.now();
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      date: date,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'date': newPlace.date.toIso8601String(),
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });
    notifyListeners();
  }

  removePlace(int id) async {
    return await DbUtil.delete(id);
  }
}
