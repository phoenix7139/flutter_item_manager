import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final List<Map<String, dynamic>> _bucketlist;
  final int _index;

  PriceTag(this._bucketlist, this._index);

  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    '₹ ${_bucketlist[_index]['price'].toString()}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
  }
}