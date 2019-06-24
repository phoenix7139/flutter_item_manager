import 'package:flutter/material.dart';

class Item {
  final String title;
  final String description;
  final double price;
  final String image;

  Item(
      {@required this.title,
      @required this.description,
      @required this.image,
      @required this.price});
}
