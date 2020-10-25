import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sightseeing/providers/places.dart';
import 'package:sightseeing/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const route = '/place/details';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final Place place =
        Provider.of<Places>(context, listen: false).getPlace(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Place details'),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(place.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.brown,
              )),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) {
                  return MapScreen(
                    initialLocation: place.location,
                    isSelecting: false,
                  );
                },
              ));
            },
            child: Text('Open in maps'),
          ),
        ],
      ),
    );
  }
}
