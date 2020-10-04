import 'package:flutter/material.dart';
import 'package:great_places/provider/great_places.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = "/add-places";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textInputController = TextEditingController();

  File _pickedImage;

  void _setPickedImage(File selectedImage) {
    _pickedImage = selectedImage;
  }

  void _submitData() {
    if (_textInputController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_textInputController.text, _pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _textInputController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(
                    onPickedImage: _setPickedImage,
                  )
                ],
              ),
            ),
          )),
          RaisedButton.icon(
            onPressed: () {
              _submitData();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            label: Text(
              "ADD PLACE",
              style: const TextStyle(fontSize: 21),
            ),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
