import 'package:flutter/foundation.dart';
import '../model/place.dart';
import '../helpers/db_helper.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    Place newPlace = Place(
        id: DateTime.now().toIso8601String(),
        title: pickedTitle,
        location: null,
        image: pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert("places", {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData("places");
    _items = data
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            location: null,
            image: File(e['image'])))
        .toList();
    notifyListeners();
  }
}
