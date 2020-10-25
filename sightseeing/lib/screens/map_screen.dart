import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sightseeing/providers/places.dart';

class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;
  MapScreen({this.initialLocation, this.isSelecting: false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _position;

  void _selectPoint(LatLng position) {
    setState(() {
      _position = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map selection'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _position != null
                  ? () => Navigator.of(context).pop(_position)
                  : null,
            ),
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting ? _selectPoint : null,
        markers: {
          Marker(
            markerId: MarkerId('A'),
            position: _position ??
                LatLng(
                  widget.initialLocation.latitude,
                  widget.initialLocation.longtitude,
                ),
          ),
        },
        initialCameraPosition: CameraPosition(
          zoom: 17,
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longtitude),
        ),
      ),
    );
  }
}
