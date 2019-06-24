import 'package:flutter/material.dart';

import './item_edit.dart';
import '../models/item_model.dart';

class ItemListPage extends StatelessWidget {
  final List<Item> _bucketlist;

  final Function _updateItem;
  final Function _deleteItem;

  ItemListPage(this._bucketlist, this._updateItem, this._deleteItem);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ItemEditPage(
                bucketlist: _bucketlist[index],
                updateItem: _updateItem,
                productIndex: index);
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20.0),
      itemBuilder: (BuildContext context, index) {
        return Dismissible(
          dismissThresholds: {
            DismissDirection.endToStart: 0.8,
            DismissDirection.startToEnd: 0.8,
          },
          key: Key(_bucketlist[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.startToEnd) {
              _deleteItem(index);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('ITEM DELETED'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
            if (direction == DismissDirection.endToStart) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return ItemEditPage(
                      bucketlist: _bucketlist[index],
                      updateItem: _updateItem,
                      productIndex: index);
                }),
              );
            }
          },
          background: Container(
              color: Colors.red,
              child: IconButton(
                color: Colors.white,
                padding: EdgeInsets.only(left: 25.0),
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.delete),
                onPressed: () {},
              )),
          secondaryBackground: Container(
            color: Colors.green,
            child: IconButton(
              // color: Colors.white,
              padding: EdgeInsets.only(right: 25.0),
              alignment: Alignment.centerRight,
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: CircleAvatar(
              backgroundImage: AssetImage(_bucketlist[index].image),
            ),
            title: Text(_bucketlist[index].title),
            subtitle: Text(_bucketlist[index].price.toString()),
            trailing: _buildEditButton(context, index),
          ),
        );
      },
      itemCount: _bucketlist.length,
    );
  }
}
