import 'package:flutter/material.dart';


import './item_card.dart';
import '../../models/item_model.dart';

class BucketList extends StatelessWidget {
  final List<Item> bucketlist;

  BucketList(this.bucketlist);


  Widget _buildList() {
    Widget defaultCard = Center(
      child: Text("No Items"),
    );
    if (bucketlist.length > 0) {
      defaultCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ItemCard(bucketlist, index),
        itemCount: bucketlist.length,
      );
    }
    return defaultCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
