import 'package:flutter/material.dart';
import 'package:martshop/providers/product.dart';
import 'package:martshop/providers/product_provider.dart';
import 'package:martshop/widgets/product_list_item.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  EditProductsScreen({super.key});

  static const String routeName = '/edit-product';

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  //To handle focus in flutter there are to important class FocusNode and FocusScope
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final TextEditingController _imageController = TextEditingController();
  final FocusNode _imageFocus = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Product _product =
      Product(name: '', price: 0, description: '', id: '', imageUrl: '');

  Product _initialProduct =
      Product(description: '', id: '', imageUrl: '', name: '', price: 0);
  bool isInit = true;

  @override
  void initState() {
    super.initState();
    _imageFocus.addListener(listener);
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final proId = ModalRoute.of(context)!.settings.arguments as String;

      _product = Provider.of<Products>(context).findById(proId);
      _initialProduct = Product(
        description: _product.description,
        id: _product.id,
        imageUrl: '',
        name: _product.name,
        price: _product.price,
      );
    }
    _imageController.text = _product.imageUrl;
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionFocus.dispose();
    _imageController.dispose();
    _priceFocus.dispose();
    _imageFocus.removeListener(listener);
    _imageFocus.dispose();
  }

  void listener() {
    if (!_imageFocus.hasFocus) {
      if (_imageController.text.isEmpty ||
          !_imageController.text.startsWith('http') ||
          !_imageController.text.startsWith('https')) {
        return;
      }

      //Just to rebuild the ui and preview the image
      setState(() {});
    }
  }

  //The handle submit method and that particular Form() must be connected to connect the two we need some form of hook
  void _handleSubmit() {
    //This will iteratively call onSaved method on each TextFormField()
    final bool isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();

      //if there is loaded id from the parent page
      if (_product.id != '') {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_product.id, _product);
      } else {
        Provider.of<Products>(context, listen: false).add(_product);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit product"),
        actions: [
          IconButton(
            onPressed: _handleSubmit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),

      //Forms in flutter

      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initialProduct.name,
                  decoration: const InputDecoration(hintText: "Title"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (value) {
                    _product = Product(
                      description: _product.description,
                      id: _product.id,
                      imageUrl: _product.imageUrl,
                      name: value!,
                      price: _product.price,
                      isFavourite: _product.isFavourite,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initialProduct.price.toString(),
                  decoration: const InputDecoration(hintText: "price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter valid price';
                    } else if (double.tryParse(value)! <= 0) {
                      return 'Please enter price above 0.0Birr';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _product = Product(
                      description: _product.description,
                      id: _product.id,
                      imageUrl: _product.imageUrl,
                      name: _product.name,
                      price: double.parse(value!),
                      isFavourite: _product.isFavourite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initialProduct.description,
                  decoration: const InputDecoration(hintText: "Description"),
                  // ! text input action are not used when working with the multiline because we do not know when the user has finished
                  // textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocus,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }

                    if (value.length < 10) {
                      return 'Description is too short';
                    }

                    return null;
                  },

                  onSaved: (value) {
                    _product = Product(
                      description: value!,
                      id: _product.id,
                      imageUrl: _product.imageUrl,
                      name: _product.name,
                      price: _product.price,
                      isFavourite: _product.isFavourite,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      width: 100,
                      height: 100,
                      child: _imageController.text.isEmpty
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/758/758462.png?w=740&t=st=1679914831~exp=1679915431~hmac=858f8d52e433adea20a7d7a4438bc1451cf97edcec1fed5602416f40b6142501"),
                            )
                          : Image.network(_imageController.text),
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _imageFocus,
                        decoration:
                            const InputDecoration(labelText: "Image Url"),
                        controller: _imageController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _handleSubmit();
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Image URL';
                          }

                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter valid url';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _product = Product(
                            description: _product.description,
                            id: _product.id,
                            imageUrl: value!,
                            name: _product.name,
                            price: _product.price,
                            isFavourite: _product.isFavourite,
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
