import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './item_price_tag.dart';
import '../../models/item_model.dart';
import '../../scoped-models/main_scoped_model.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final int _index;

  ItemCard(this.item, this._index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(item.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img.jpg'),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                PriceTag(item.price),
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
          Text(item.userEmail),
          // Text(bucketlist[index]['description']),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    // color: Theme.of(context).primaryColor,
                    icon: Icon(Icons.info),
                    onPressed: () {
                      Navigator.pushNamed<bool>(
                          context, '/item/' + model.allItems[_index].id);
                    },
                  ),
                  IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(model.allItems[_index].isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      model.selectItem(model.allItems[_index].id);
                      model.toggleIsFavourite();
                    },
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
