import 'package:flutter/material.dart';

import 'product.dart';

//This is our data model that containt the data of the app
//we can think of this as A single source of truth hence we will set all our data and also methods to get and add to that data

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        description: "Best Iphone app for you with 128GB storage and 16GB RAM",
        id: "1",
        imageUrl:
            "https://img.freepik.com/free-psd/full-screen-smartphone-mockup-design_53876-57919.jpg?w=740&t=st=1678984775~exp=1678985375~hmac=73f2e36ef2414a90862c8a7e92d12eed4649245fd2573074ff7049fbc970a444",
        name: "Iphone ProMax",
        price: 13000),
    Product(
        description:
            "Brand New PC, Just For you 1TB storage with core i7 processor",
        id: "2",
        imageUrl:
            "https://img.freepik.com/free-psd/laptop-psd-mockup-with-gradient-led-light_53876-138283.jpg?w=740&t=st=1678984755~exp=1678985355~hmac=51cb50e9efd16976bfa59d03fe4fa4ffb46f4640845ff5e78b228b72f4873443",
        name: "HP Elite",
        price: 24000),
    Product(
        description:
            "Professional Camera with ultera HD defination, portable for any place",
        id: "3",
        imageUrl:
            "https://img.freepik.com/free-vector/camera-accessory_1284-13130.jpg?w=740&t=st=1678984692~exp=1678985292~hmac=8381b58ce6389de49ad91c2b2e61c41098c04d28bffcb6a364ab451f8a306f99",
        name: "Camera 50x",
        price: 18000),
    Product(
        description:
            "Brand new T-shirt 100% cotton with fair price. We have many diffrent sizes",
        id: "4",
        imageUrl:
            "https://img.freepik.com/free-vector/sports-shirt-design-ready-print-football-shirt-sublimation_29096-4072.jpg?w=740&t=st=1678984635~exp=1678985235~hmac=0e3a34541dfd49c4349ab8eab05f8061a8a5099c90340e4f11e23edf3f74ae98",
        name: "T-Shirt",
        price: 300),
    Product(
      id: '5',
      name: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: '6',
      name: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: '7',
      name: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: '8',
      name: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items => [..._items];

  //just like get method --fillterd
  Product findById(String id) =>
      _items.firstWhere((element) => element.id == id);

  void add(Product product) {
    final newProduct = Product(
        description: product.description,
        id: DateTime.now().toString(),
        imageUrl: product.imageUrl,
        name: product.name,
        price: product.price);
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, newProduct) {
    final int index = _items.indexWhere((element) => element.id == id);
    if (index >= 0) {
      _items[index] = newProduct;
    }
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  List<Product> get favItems =>
      _items.where((prodItem) => prodItem.isFavourite).toList();
}
