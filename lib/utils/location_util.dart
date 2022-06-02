// ignore_for_file: unused_local_variable, constant_identifier_names

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

//android:value="AIzaSyDa0_yckRVTYs5xXh1FlNW8RIfwCxaf0pY"/>
//chave AIzaSyDOAA9WryNXsETeBkj0qBa91CfnbUNGoJE
const GOOGLE_API_KEY = 'AIzaSyDa0_yckRVTYs5xXh1FlNW8RIfwCxaf0pY';

class LocationUtil {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${latitude},${longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${latitude},${longitude}&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    var url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY',
    );
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
