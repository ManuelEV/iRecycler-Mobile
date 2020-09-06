import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PointImage extends StatefulWidget {
  @override
  _PointImageState createState() => _PointImageState();
}

class _PointImageState extends State<PointImage> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _showPointImage(),
        _addPointImage(),
      ],
    );
  }

  Widget _showPointImage() {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: _storedImage != null
          ? Image.file(
              _storedImage,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          : Text('No hay una imagen'),
    );
  }

  Widget _addPointImage() {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton.icon(
        icon: Icon(Icons.add_a_photo),
        label: Text('Picture'),
        onPressed: _takePicture,
      ),
    );
  }
}
