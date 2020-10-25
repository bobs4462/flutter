import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sightseeing/helpers/maps.dart';
import 'package:sightseeing/screens/map_screen.dart';
import 'package:sightseeing/providers/places.dart' as pls;

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<pls.Location> _getCurrentLocation() async {
    final location = await Location().getLocation();
    final url = GMapsHelper.getMapImageUrl(
      latitude: location.latitude,
      longtitude: location.longitude,
    );
    setState(() => _previewImageUrl = url);
    widget.onSelectPlace(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    return pls.Location(
        longtitude: location.longitude, latitude: location.latitude);
  }

  Future<void> _selectOnMap() async {
    final currentLocation = await _getCurrentLocation();
    final LatLng selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) {
          return MapScreen(
            isSelecting: true,
            initialLocation: currentLocation,
          );
        },
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final url = GMapsHelper.getMapImageUrl(
      latitude: selectedLocation.latitude,
      longtitude: selectedLocation.longitude,
    );
    setState(() => _previewImageUrl = url);
    widget.onSelectPlace(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 230,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select location on map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
