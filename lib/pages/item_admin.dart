import 'package:flutter/material.dart';

import 'item_edit.dart';
import 'item_list.dart';
import '../models/item_model.dart';

class ProductsAdmin extends StatelessWidget {
  final List<Item> _bucketlist;

  final Function _add;
  final Function _delete;
  final Function _update;

  ProductsAdmin(this._bucketlist, this._add, this._update, this._delete);

  Widget _buildAdminDrawer(BuildContext context) {
    return Drawer(
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: _buildAdminDrawer(context),
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
              ItemEditPage(addItem: _add),
              ItemListPage(_bucketlist, _update, _delete),
            ],
          )),
    );
  }
}
