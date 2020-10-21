import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/product.dart';
import 'package:shopping/providers/products.dart';

class ProductEditorScreen extends StatefulWidget {
  static const String route = '/product/editor';
  @override
  _ProductEditorScreenState createState() => _ProductEditorScreenState();
}

class _ProductEditorScreenState extends State<ProductEditorScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String> initValues = {
    'title': '',
    'description': '',
    'price': '',
    // 'imageUrl': '',
  };
  final Map<String, String Function(String)> validators = {
    'title': (value) {
      if (value.isNotEmpty) {
        return null;
      } else {
        return 'Please enter the title';
      }
    },
    'price': (value) {
      if (value.isNotEmpty) {
        try {
          double.parse(value);
        } catch (exception) {
          return 'Invalid number';
        }
        return null;
      } else {
        return 'Please enter the price';
      }
    },
    'description': (value) {
      if (value.isNotEmpty) {
        return null;
      } else {
        return 'Please enter the description';
      }
    },
    'imageUrl': (value) {
      if (value.isNotEmpty) {
        return null;
      } else {
        return 'Please enter the image url';
      }
    },
  };
  Product _product;

  @override
  void didChangeDependencies() {
    _product = ModalRoute.of(context).settings.arguments as Product;
    if (_product != null) {
      initValues['title'] = _product.title;
      initValues['description'] = _product.description;
      initValues['price'] = _product.price.toString();
      _imageUrlController.text = _product.imageUrl;
      // initValues['imageUrl'] = _product.imageUrl;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_product.id != null) {
      await Provider.of<Products>(context, listen: false)
          .editProduct(_product)
          .catchError((error) => print(error));
    } else {
      await Provider.of<Products>(context, listen: false)
          .addProduct(_product)
          .catchError((error) {
        return showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error occured'),
            content: Text(error.toString()),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        );
      });
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product editor'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _product = Product(
                        title: value,
                        isFavorite: _product?.isFavorite ?? false,
                        description: _product?.description ?? '',
                        price: _product?.price ?? 0.0,
                        imageUrl: _product?.imageUrl ?? '',
                        id: _product?.id,
                      ),
                      validator: validators['title'],
                      initialValue: initValues['title'],
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      validator: validators['price'],
                      onSaved: (String value) => _product = Product(
                        isFavorite: _product?.isFavorite ?? false,
                        title: _product.title,
                        description: _product?.description ?? '',
                        price: double.parse(value),
                        imageUrl: _product?.imageUrl ?? '',
                        id: _product.id,
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode),
                      keyboardType: TextInputType.number,
                      initialValue: initValues['price'],
                      focusNode: _priceFocusNode,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: validators['description'],
                      initialValue: initValues['description'],
                      onSaved: (String value) => _product = Product(
                        isFavorite: _product?.isFavorite ?? false,
                        title: _product.title,
                        description: value,
                        price: _product?.price ?? 0.0,
                        imageUrl: _product?.imageUrl ?? '',
                        id: _product.id,
                      ),
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          margin: EdgeInsets.only(
                            top: 10,
                            right: 12,
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Expecting correct url')
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'Image url',
                            ),
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _saveForm(),
                            validator: validators['imageUrl'],
                            onSaved: (String value) => _product = Product(
                              title: _product.title,
                              description: _product?.description ?? '',
                              price: _product.price,
                              imageUrl: value,
                              id: _product.id,
                              isFavorite: _product?.isFavorite ?? false,
                            ),
                            focusNode: _imageUrlFocusNode,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
