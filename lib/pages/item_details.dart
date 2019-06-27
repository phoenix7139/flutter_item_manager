import 'dart:async';

import 'package:flutter/material.dart';


import '../models/item_model.dart';

class Details extends StatelessWidget {
  final Item item;

  Details(this.item);

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
      child: Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          title: Text(item.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(item.image),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/img.jpg'),
              ),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald',
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: _buildAddressPriceRow(item.price.toString()),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(5.0),
                child: Text(
                  item.description,
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
      ),
    );
  }
}
