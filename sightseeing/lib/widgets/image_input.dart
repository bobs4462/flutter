import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pp;

class ImageInput extends StatefulWidget {
  final Function imagePicker;
  ImageInput(this.imagePicker);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: _image != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image yet',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
          width: 350,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('take picture'),
            onPressed: () async {
              final imageFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxHeight: 1366,
                maxWidth: 768,
              );
              if (imageFile == null) {
                return;
              }
              setState(() => _image = File(imageFile.path));
              final appDir = await pp.getApplicationDocumentsDirectory();
              final fileName = path.basename(imageFile.path);
              final savedImage = await _image.copy('${appDir.path}/$fileName');
              widget.imagePicker(savedImage);
            },
          ),
        ),
      ],
    );
  }
}
