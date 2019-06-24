import 'package:flutter/material.dart';

import '../widgets/items/item_list_builder.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> tempList;

  HomePage(this.tempList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('OPTIONS'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            ListTile(
              subtitle: Text('to manage items'),
              leading: Icon(Icons.edit),
              title: Text('MANAGE ITEMS'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('BucketList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {

            },
            color: Theme.of(context).accentColor,
          )
        ],
      ),
      body: BucketList(tempList),
    );
  }
}
