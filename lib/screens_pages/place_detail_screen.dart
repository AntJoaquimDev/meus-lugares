import 'package:flutter/material.dart';
import 'package:great_place/models/place.dart';
import 'package:great_place/screens_pages/map_screen.dart';
import 'package:intl/intl.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 500,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Local da Imagem: ${place.location.address}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 10),
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Ver local no mapa'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    isReadonly: true,
                    initialLocation: place.location,
                  ),
                ));
              },
            ),
            Row(
              children: [
                Text(
                  '${DateFormat('dd/MM/yyyy hh:mm').format(place.date).toString()}\n Lat: ${place.location.latitude.toString()} \n Lng: ${place.location.longitude.toString()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
