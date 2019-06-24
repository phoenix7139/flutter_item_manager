import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../models/item_model.dart';

class ItemEditPage extends StatefulWidget {
  final Function addItem;
  final Function updateItem;

  final Item bucketlist;
  final int productIndex;

  ItemEditPage(
      {this.addItem, this.updateItem, this.bucketlist, this.productIndex});

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

  Widget _buidldTitleTextField() {
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
        initialValue: widget.bucketlist == null ? '' : widget.bucketlist.title,
        onSaved: (String value) {
          _formData['title'] = value;
        },
        validator: (String value) {
          if (value.isEmpty) return 'TITLE IS REQUIRED';
        },
      ),
    );
  }

  Widget _buildDescriptionTextField() {
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
        initialValue:
            widget.bucketlist == null ? '' : widget.bucketlist.description,
        onSaved: (String value) {
          _formData['description'] = value;
        },
        validator: (String value) {
          if (value.isEmpty) return 'DESCRIPTION IS REQUIRED';
        },
      ),
    );
  }

  Widget _buildPriceField() {
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
        initialValue:
            widget.bucketlist == null ? '' : widget.bucketlist.price.toString(),
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

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: FlatButton(
        splashColor: Theme.of(context).primaryColor,
        child: widget.bucketlist == null ? Text('ADD') : Text('UPDATE'),
        onPressed: _addItemAndExitPage,
      ),
    );
  }

  void _addItemAndExitPage() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.bucketlist == null) {
      widget.addItem(Item(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      ));
    } else {
      widget.updateItem(
          Item(
            title: _formData['title'],
            description: _formData['description'],
            price: _formData['price'],
            image: _formData['image'],
          ),
          widget.productIndex);
    }
    Navigator.pushReplacementNamed(context, '/display');
  }

  @override
  Widget build(BuildContext context) {
    final double _targetWidth = MediaQuery.of(context).size.width > 550.0
        ? 500.0
        : MediaQuery.of(context).size.width * 0.95;

    final Widget PageContent = GestureDetector(
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
              _buidldTitleTextField(),
              SizedBox(
                height: 10.0,
              ),
              _buildDescriptionTextField(),
              SizedBox(
                height: 10.0,
              ),
              _buildPriceField(),
              SizedBox(
                height: 20.0,
              ),
              _buildSubmitButton()
            ],
          ),
        ),
      ),
    );

    return widget.bucketlist == null
        ? PageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('EDIT ITEM : ${widget.bucketlist.title}'),
            ),
            body: PageContent,
          );
  }
}
