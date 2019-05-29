import 'package:flutter/material.dart';

import './list.dart';

class ItemAdder extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _ItemAdderState();
  }
}

class _ItemAdderState extends State<ItemAdder> {
  List<String> _bucketlist = ['first entry'];

  @override
  Widget build(BuildContext context) {
    return Column(children:  [Container(
              margin: EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _bucketlist.add('new entry');
                  });
                },
                child: Text('add entry'),
              ),
            ),
            BucketList(_bucketlist)
            ],);
  }
}