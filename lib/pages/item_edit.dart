import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../models/item_model.dart';
import '../scoped-models/main_scoped_model.dart';

class ItemEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemEditPageState();
  }
}

class _ItemEditPageState extends State<ItemEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/img.jpg',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buidldTitleTextField(Item bucketlist) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Color(0xffecfffb),
          labelText: 'item title',
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: new BorderRadius.circular(10)),
        ),
        initialValue: bucketlist == null ? '' : bucketlist.title,
        onSaved: (String value) {
          _formData['title'] = value;
        },
        validator: (String value) {
          if (value.isEmpty) return 'TITLE IS REQUIRED';
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Item bucketlist) {
    return EnsureVisibleWhenFocused(
      focusNode: _descFocusNode,
      child: TextFormField(
        focusNode: _descFocusNode,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Color(0xffecfffb),
          labelText: 'item description',
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: new BorderRadius.circular(10)),
        ),
        maxLines: 4,
        initialValue: bucketlist == null ? '' : bucketlist.description,
        onSaved: (String value) {
          _formData['description'] = value;
        },
        validator: (String value) {
          if (value.isEmpty) return 'DESCRIPTION IS REQUIRED';
        },
      ),
    );
  }

  Widget _buildPriceField(Item bucketlist) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Color(0xffecfffb),
          labelText: 'item price',
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: new BorderRadius.circular(10)),
        ),
        keyboardType: TextInputType.number,
        initialValue: bucketlist == null ? '' : bucketlist.price.toString(),
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        },
        validator: (String value) {
          if (value.isEmpty) return 'PRICE IS REQUIRED';
          if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value))
            return 'PRICE SHOULD BE NUMERICAL';
        },
      ),
    );
  }

  Widget _buildSubmitButton(Item bucketlist) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Align(
          alignment: Alignment.bottomRight,
          child: model.isLoading
              ? LinearProgressIndicator()
              : FlatButton(
                  splashColor: Theme.of(context).primaryColor,
                  child: bucketlist == null ? Text('ADD') : Text('UPDATE'),
                  onPressed: () => _addItemAndExitPage(
                      model.addItem,
                      model.updateItem,
                      model.selectItem,
                      model.selectedItemIndex),
                ),
        );
      },
    );
  }

  void _addItemAndExitPage(Function _addItem, Function _updateItem,
      Function _setSelectedProduct, int selectedItemIndex) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedItemIndex == null) {
      _addItem(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/display')
        .then((_) => _setSelectedProduct(null)));
    } else {
      _updateItem(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/display')
        .then((_) => _setSelectedProduct(null)));
    }
    
  }

  Widget _buildPageContent(BuildContext context, Item selectedItem) {
    final double _targetWidth = MediaQuery.of(context).size.width > 550.0
        ? 500.0
        : MediaQuery.of(context).size.width * 0.95;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal:
                    (MediaQuery.of(context).size.width - _targetWidth) / 2),
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              _buidldTitleTextField(selectedItem),
              SizedBox(
                height: 10.0,
              ),
              _buildDescriptionTextField(selectedItem),
              SizedBox(
                height: 10.0,
              ),
              _buildPriceField(selectedItem),
              SizedBox(
                height: 20.0,
              ),
              _buildSubmitButton(selectedItem)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget PageContent =
            _buildPageContent(context, model.selectedItem);
        return model.selectedItemIndex == null
            ? PageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('EDIT ITEM : ${model.selectedItem.title}'),
                ),
                body: PageContent,
              );
      },
    );
  }
}
