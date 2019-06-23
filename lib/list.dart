import 'package:flutter/material.dart';

// import './pages/item_details.dart';

class BucketList extends StatelessWidget {
  final List<Map> bucketlist;
  final Function tempDeleteItem;

  BucketList(this.bucketlist, this.tempDeleteItem);

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(bucketlist[index]['image']),
          Text(bucketlist[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("DETAILS"),
                onPressed: () {
                  Navigator.pushNamed<bool>(context, '/item/' + index.toString())
                  .then((bool value) {
                    if (value) {
                      tempDeleteItem(index);
                    }
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    Widget defaultCard = Center(
      child: Text("No Items"),
    );
    if (bucketlist.length > 0) {
      defaultCard = ListView.builder(
        itemBuilder: _buildItem,
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
