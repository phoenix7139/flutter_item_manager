import 'package:flutter/material.dart';

// import 'home.dart';
import 'item_create.dart';
import 'item_list.dart';

class ProductsAdmin extends StatelessWidget {
  final Function add;
  final Function delete;

  ProductsAdmin(this.add, this.delete);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  leading: Icon(Icons.list),
                  title: Text('ALL ITEMS'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/display');
                  },
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('MANAGE ITEMS'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'create items',
                  icon: Icon(Icons.add),
                ),
                Tab(
                  text: 'my items',
                  icon: Icon(Icons.view_list),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ItemCreatePage(add, delete),
              ItemListPage(),
            ],
          )),
    );
  }
}
