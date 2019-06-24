import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    '₹ $_price',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
  }
}