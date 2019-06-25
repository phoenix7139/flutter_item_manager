import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './item_edit.dart';
import '../scoped-models/main_scoped_model.dart';

class ItemListPage extends StatefulWidget {
   final MainModel model;

   ItemListPage(this.model);
   
  @override
  State<StatefulWidget> createState() {
    return _ItemListPageState();
  }
}
class _ItemListPageState extends State<ItemListPage>
{
  @override
  initState() {
    widget.model.fetchItems();
    super.initState();
  }


  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectItem(index);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ItemEditPage();
          }),
        ).then(
          (_) {
            model.selectItem(null);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          padding: EdgeInsets.only(top: 20.0),
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
              dismissThresholds: {
                DismissDirection.endToStart: 0.8,
                DismissDirection.startToEnd: 0.8,
              },
              key: Key(model.allItems[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  model.selectItem(index);
                  model.deleteItem();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('ITEM DELETED'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
                if (direction == DismissDirection.endToStart) {
                  model.selectItem(index);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return ItemEditPage();
                    }),
                  );
                }
              },
              background: Container(
                  color: Colors.red,
                  child: IconButton(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 25.0),
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  )),
              secondaryBackground: Container(
                color: Colors.green,
                child: IconButton(
                  // color: Colors.white,
                  padding: EdgeInsets.only(right: 25.0),
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(model.allItems[index].image),
                ),
                title: Text(model.allItems[index].title),
                subtitle: Text(model.allItems[index].price.toString()),
                trailing: _buildEditButton(context, index, model),
              ),
            );
          },
          itemCount: model.allItems.length,
        );
      },
    );
  }
}
