import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// import '../item_manager.dart';
import '../scoped-models/main_scoped_model.dart';

class Details extends StatelessWidget {
  final int _productIndex;

  Details(this._productIndex);

  Widget _buildAddressPriceRow(String price) {
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
          child: Text('₹ ${price.toString()}',
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
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Scaffold(
            appBar: AppBar(
              elevation: 10.0,
              title: Text(model.allItems[_productIndex].title),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Image.network(model.allItems[_productIndex].image),
                  Text(
                    model.allItems[_productIndex].title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: _buildAddressPriceRow(model.allItems[_productIndex].price.toString()),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      model.allItems[_productIndex].description,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Text(bucketlist[index]['description']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
