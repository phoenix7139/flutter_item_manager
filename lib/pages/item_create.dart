import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCreatePage extends StatefulWidget {
  final Function add;
  final Function delete;

  ItemCreatePage(this.add, this.delete);

  @override
  State<StatefulWidget> createState() {
    return _ItemCreatePageState();
  }
}

class _ItemCreatePageState extends State<ItemCreatePage> {
  String _titleValue = '';
  String _descriptValueion = '';
  double _priceValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0,),
          TextField(
            decoration: InputDecoration(
              // filled: true,
              // fillColor: Color(0xffecfffb),
              labelText: 'item title',
              border: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: new BorderRadius.circular(10)),
            ),
            onChanged: (String value) {
              setState(() {
                _titleValue = value;
              });
            },
          ),
          SizedBox(height: 10.0,),
          TextField(
            decoration: InputDecoration(
              // filled: true,
              // fillColor: Color(0xffecfffb),
              labelText: 'item description',
              border: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: new BorderRadius.circular(10)),
            ),
            maxLines: 4,
            onChanged: (String value) {
              setState(() {
                _descriptValueion = value;
              });
            },
          ),
          SizedBox(height: 10.0,),
          TextField(
            decoration: InputDecoration(
              // filled: true,
              // fillColor: Color(0xffecfffb),
              labelText: 'item price',
              border: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: new BorderRadius.circular(10)),
            ),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                _priceValue = double.parse(value);
              });
            },
          ),
          SizedBox(height: 20.0,),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              splashColor: Theme.of(context).primaryColor,
              child: Text('ADD'),
              onPressed: () {
                final Map<String, dynamic> tempItem = {
                  'title': _titleValue,
                  'description': _descriptValueion,
                  'price': _priceValue,
                  'image': 'assets/img.jpg',
                };
                setState(() {
                  widget.add(tempItem);
                  Navigator.pushReplacementNamed(context, '/display');
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
