import 'package:flutter/material.dart';

class Item {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFavourite;
  final String userEmail;
  final String userId;

  Item(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.image,
      @required this.price,
      @required this.userEmail,
      @required this.userId,
      this.isFavourite = false});
}
