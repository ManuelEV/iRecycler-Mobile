import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PointImage extends StatefulWidget {
  final Function onSelectImage;
  PointImage(this.onSelectImage);

  @override
  _PointImageState createState() => _PointImageState();
}

class _PointImageState extends State<PointImage> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 1000,
    );
    setState(() {
      _storedImage = File(imageFile.path);
      widget.onSelectImage(_storedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _showPointImage(),
        //_addPointImage(),
      ],
    );
  }

  Widget _showPointImage() {
    return Container(
      width: 250,
      height: 250,
      alignment: Alignment.center,
      child: _storedImage != null
          ? Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    image: DecorationImage(
                      image: FileImage(_storedImage),
                      fit: BoxFit.values[2],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(125),
                    ),
                  ),
                  child: null,
                ),
                _addPointImage(true),
              ],
            )
          : Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    image: DecorationImage(
                      image: AssetImage('default-pick-image.jpg'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(130),
                    ),
                  ),
                  child: null,
                ),
                _addPointImage(false),
              ],
            ),
    );
  }

  Widget _addPointImage(bool isPicked) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: Icon(
          Icons.add_a_photo,
          color: isPicked ? Colors.grey[300] : Colors.grey[600],
        ),
        textColor: isPicked ? Colors.grey[300] : Colors.grey[600],
        onPressed: _takePicture,
        color: isPicked ? Colors.transparent : Colors.grey[200],
      ),
    );
  }
}
