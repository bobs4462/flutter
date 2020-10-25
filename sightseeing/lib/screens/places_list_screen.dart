import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sightseeing/providers/places.dart';
import 'package:sightseeing/screens/add_place_screen.dart';
import 'package:sightseeing/screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  static const String route = '/places/list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.route),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSet(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<Places>(
                builder: (ctx, places, child) {
                  final placesList = places.items;
                  return places.placeCount == 0
                      ? child
                      : ListView.builder(
                          itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(placesList[i].image),
                                ),
                                title: Text(placesList[i].title),
                                subtitle: Text(placesList[i].location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.route,
                                    arguments: placesList[i].id,
                                  );
                                },
                              ),
                          itemCount: places.placeCount);
                },
                child: Center(
                  child: const Text('No places yet, try adding new ones!'),
                ),
              ),
      ),
    );
  }
}
