import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './item_price_tag.dart';
import '../../models/item_model.dart';
import '../../scoped-models/main_scoped_model.dart';

class ItemCard extends StatelessWidget {
  final List<Item> _bucketlist;
  final int _index;

  ItemCard(this._bucketlist, this._index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(_bucketlist[_index].image),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _bucketlist[_index].title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                PriceTag(_bucketlist[_index].price),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0, color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(6.0)),
            child: Text('Kaushambi, New Delhi'),
          ),
          Text(_bucketlist[_index].userEmail),
          // Text(bucketlist[index]['description']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                // color: Theme.of(context).primaryColor,
                icon: Icon(Icons.info),
                onPressed: () {
                  Navigator.pushNamed<bool>(
                      context, '/item/' + _index.toString());
                },
              ),
              ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(model.allItems[_index].isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      model.selectItem(_index);
                      model.toggleIsFavourite();
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
