import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String name;
  final String id;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavourite;

  Product({
    required this.description,
    required this.id,
    required this.imageUrl,
    this.isFavourite = false,
    required this.name,
    required this.price,
  });

  //Checking if the product is toggled
  void togglesisFav() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}



//We want this model to be not just a model  we also want it to be a provider beacuse we are intested in not the array of Product rather we are intrested on the single product, we wanted to manage the sate of the single product 