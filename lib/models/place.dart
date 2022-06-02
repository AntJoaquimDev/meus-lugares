import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    this.latitude,
    this.longitude,
    this.address,
  });

  LatLng toLatLng() {
    // ignore: unnecessary_this
    return LatLng(this.latitude, this.longitude);
  }
}

class Place {
  final String id;
  final String title;
  final DateTime date;
  final PlaceLocation location;
  final File image;

  Place({
    this.id,
    this.title,
    this.date,
    this.location,
    this.image,
  });
}
