import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './item_card.dart';
import '../../models/item_model.dart';
import '../../scoped-models/main_scoped_model.dart';

class BuildItemList extends StatelessWidget {
  Widget _buildList(List<Item> bucketlist) {
    Widget defaultCard = Center(
      child: Text("No Items"),
    );
    if (bucketlist.length > 0) {
      defaultCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ItemCard(bucketlist, index),
        itemCount: bucketlist.length,
      );
    }
    return defaultCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildList(model.displayedItems);
      },
    );
  }
}
