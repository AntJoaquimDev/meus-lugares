import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
//import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadonly;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: -3.1799632,
      longitude: -41.870170,
    ),
    this.isReadonly = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
      print(_pickedPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione...'),
        actions: [
          if (!widget.isReadonly)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isReadonly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadonly)
            ? Set()
            : {
                // ignore: prefer_const_constructors
                Marker(
                  markerId: MarkerId('p1'),
                  position:
                      _pickedPosition ?? widget.initialLocation.toLatLng(),
                ),
              },
      ),
    );
  }
}
/*LatLng(
                    -3.1800,
                    -41.8701,
                  ),*/
//LatLng buriti my house
//  -3.1800,
//  -41.8701,
