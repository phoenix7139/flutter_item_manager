import 'package:flutter/material.dart';

// import 'home.dart';
import 'item_create.dart';
import 'item_list.dart';

class ProductsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
      child:
     Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('OPTIONS'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            ListTile(
              subtitle: Text('see all items'),
              leading: Icon(Icons.assignment),
              title: Text('ALL ITEMS'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('MANAGE ITEMS'),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text:'create product', icon: Icon(Icons.add),),
            Tab(text: 'manage products', icon: Icon(Icons.list),)
          ],
        ),
      ),
      body: TabBarView(children: <Widget>[
        ItemCreatePage(),
        ItemListPage(),
      ],)
    ),
    );
  }
}
