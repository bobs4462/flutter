import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sightseeing/providers/places.dart';
import 'package:sightseeing/widgets/image_input.dart';
import 'package:sightseeing/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String route = '/place/add';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  Location _location;
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Place title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.add),
            label: Text('Add place'),
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _image == null || _location == null)
      return;
    Provider.of<Places>(context, listen: false).addPlace(
        title: _titleController.text, image: _image, location: _location);
    Navigator.of(context).pop();
  }

  void _selectImage(File image) {
    _image = image;
  }

  void _selectPlace({double latitude, double longitude}) {
    setState(() {
      _location = Location(latitude: latitude, longtitude: longitude);
    });
  }
}
