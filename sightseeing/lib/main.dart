import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sightseeing/providers/places.dart';
import 'package:sightseeing/screens/add_place_screen.dart';
import 'package:sightseeing/screens/place_detail_screen.dart';
import 'package:sightseeing/screens/places_list_screen.dart';

void main() {
  runApp(SightSeeingApp());
}

class SightSeeingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Places(),
      child: MaterialApp(
        title: 'Sightseeing!',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.route: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.route: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
