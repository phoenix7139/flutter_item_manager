import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/items/item_list_builder.dart';
import '../scoped-models/main_scoped_model.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    widget.model.fetchItems();
    super.initState();
  }

  Widget _buildHomeDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  Widget _buildItemsList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
        child: Text('NO ITEMS'),
      );
      if (model.displayedItems.length > 0 && !model.isLoading) {
        content = BuildItemList();
      } else if (model.isLoading) {
        content = LinearProgressIndicator(backgroundColor: Colors.green,);
      }
      return content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildHomeDrawer(context),
      appBar: AppBar(
        title: Text('BucketList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavourites
                    ? Icons.filter_none
                    : Icons.filter_list),
                onPressed: () {
                  model.toggleDisplayMode();
                },
                color: Theme.of(context).accentColor,
              );
            },
          ),
        ],
      ),
      body: _buildItemsList(),
    );
  }
}
