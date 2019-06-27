import 'package:flutter/material.dart';
import 'package:myapp/scoped-models/main_scoped_model.dart';

import 'item_edit.dart';
import 'item_list.dart';
import '../scoped-models/main_scoped_model.dart';

import '../widgets/ui_elements/logout_list_tile.dart';

class ItemsAdmin extends StatelessWidget {
  final MainModel model;

  ItemsAdmin(this.model);

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
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          LogoutListTile(),
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
              ItemEditPage(),
              ItemListPage(model),
            ],
          )),
    );
  }
}
