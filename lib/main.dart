import 'package:flutter/material.dart';
import 'package:great_place/providers/great_places.dart';
import 'package:great_place/screens_pages/place_detail_screen.dart';
import 'package:great_place/screens_pages/places_form_screen.dart';
import 'package:great_place/screens_pages/places_list_screens.dart';
import 'package:great_place/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places...',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
            secondary: Colors.amber,
          ),
        ),
        home: PlacesListScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.PLACE_FORM: (context) => PlaceFormeScreen(),
          AppRoutes.PLACE_DETAIL: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
