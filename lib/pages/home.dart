import 'package:flutter/material.dart';

import '../item_manager.dart';

class HomePage extends StatelessWidget {
   final List <Map<String, String>> tempList;
   final Function add;
   final Function subtract;

   HomePage(this.tempList, this.add, this.subtract);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: 
      Column(children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('OPTIONS'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        ListTile(
          subtitle: Text('to manage items'),
          leading: Icon(Icons.assignment),
          title: Text('MANAGE ITEMS'),onTap: () {
            Navigator.pushReplacementNamed(context, '/admin');
          },
        )
      ],)
      ,),
      appBar: AppBar(
          title:Text('BucketList'),
      ),
      body: ItemAdder(tempList, add, subtract),
    );
  }
}
