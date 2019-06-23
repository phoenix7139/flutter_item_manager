import 'package:flutter/material.dart';

import './list.dart';
import './item_button.dart';

class ItemAdder extends StatelessWidget {
  final List<Map<String, String>> tempBucketList;
  final Function addItem;
  final Function deleteItem;

  ItemAdder(this.tempBucketList, this. addItem, this.deleteItem);

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          child: ItemButton(addItem),
        ),
        Expanded(
          child: BucketList(tempBucketList,deleteItem),
        ),
      ],
    );
  }
}
