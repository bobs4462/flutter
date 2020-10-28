import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File imagePicked) onImagePick;
  UserImagePicker(this.onImagePick);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  Future<void> _imagePick() async {
    final File image = File((await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 300,
    ))
        .path);
    setState(() {
      _image = image;
    });
    widget.onImagePick(image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey[500],
          backgroundImage: _image == null ? null : FileImage(_image),
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.image),
          onPressed: _imagePick,
          label: Text('Your image'),
        ),
      ],
    );
  }
}
