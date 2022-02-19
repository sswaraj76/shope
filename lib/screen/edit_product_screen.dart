import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routName = "/editingScreen";
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageInput = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _runOnce = true;
  var _editedData =
      Product(id: null, title: "", description: "", imageUrl: "", price: 0);
  var _initData = {"title": "", "price": "", "description": "", "imageURl": ""};
  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void dispose() {
    _imageInput.dispose();
    _imageFocusNode.removeListener(_updateImage);
    _imageFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_runOnce) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != "") {
        _editedData =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initData = {
          "title": _editedData.title!,
          "price": _editedData.price.toString(),
          "description": _editedData.description!,
          "imageURl": ""
        };
        _imageInput.text = _editedData.imageUrl!;
      }
    }
    _runOnce = false;
    super.didChangeDependencies();
  }

  void _saveData() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (_editedData.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateItem(_editedData.id!, _editedData);
    } else {
      Provider.of<Products>(context, listen: false).addItem(_editedData);
    }

    Navigator.of(context).pop();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Products"),
        actions: [
          IconButton(
            onPressed: _saveData,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initData["title"],
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (val) {
                  _editedData = Product(
                    id: _editedData.id,
                    isfavorite: _editedData.isfavorite,
                    title: val,
                    description: _editedData.description,
                    imageUrl: _editedData.imageUrl,
                    price: _editedData.price,
                  );
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter Title";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initData["price"],
                decoration: const InputDecoration(
                  label: Text("Price"),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter Price";
                  }
                  if (double.tryParse(val) == null) {
                    return "Please enter Valid Number";
                  }
                  if (double.parse(val) <= 0) {
                    return "Please enter value grater then 0";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedData = Product(
                    id: _editedData.id,
                    isfavorite: _editedData.isfavorite,
                    title: _editedData.title,
                    description: _editedData.description,
                    imageUrl: _editedData.imageUrl,
                    price: double.parse(val!),
                  );
                },
              ),
              TextFormField(
                initialValue: _initData["description"],
                decoration: const InputDecoration(
                  label: Text("Description"),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (val) {
                  _editedData = Product(
                    id: _editedData.id,
                    isfavorite: _editedData.isfavorite,
                    title: _editedData.title,
                    description: val,
                    imageUrl: _editedData.imageUrl,
                    price: _editedData.price,
                  );
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter Description";
                  }
                  if (val.length < 10) {
                    return "Please enter Description atleast of 30 words";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10, top: 15),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: _imageInput.text.isEmpty
                        ? const Text("Enter Url")
                        : FittedBox(
                            child: Image.network(_imageInput.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Image URL"),
                      ),
                      textInputAction: TextInputAction.done,
                      controller: _imageInput,
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (_) => _saveData(),
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (val) {
                        _editedData = Product(
                          id: _editedData.id,
                          isfavorite: _editedData.isfavorite,
                          title: _editedData.title,
                          description: _editedData.description,
                          imageUrl: val,
                          price: _editedData.price,
                        );
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Image URL";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
