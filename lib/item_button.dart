import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final Function tempAddItem;

  ItemButton(this.tempAddItem);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).secondaryHeaderColor,
      splashColor: Colors.amber,
      onPressed: () {
        tempAddItem({'title': 'NEW ITEM', 'image': 'assets/img.jpg'});
      },
      child: Text('ADD ITEM'),
    );
  }
}
