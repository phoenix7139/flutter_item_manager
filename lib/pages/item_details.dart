import 'dart:async';

import 'package:flutter/material.dart';

// import '../item_manager.dart';

class Details extends StatelessWidget {
  final String _title;
  final String _imageURL;
  final double _price;
  final String _description;

  Details(this._title, this._imageURL, this._price, this._description);

  Widget _buildAddressPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
          margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
          child: Text('Kaushambi, New Delhi',
              style: TextStyle(color: Colors.grey)),
        ),
        Container(
          child: Text('|', style: TextStyle(color: Colors.grey)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
          margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
          child: Text('₹ ${_price.toString()}',
              style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 10.0,
            title: Text(_title),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Image.asset(_imageURL),
                Text(
                  _title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald',
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: _buildAddressPriceRow(),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    _description,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Text(bucketlist[index]['description']),
              ],
            ),
          )),
    );
  }
}
