import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../item_manager.dart';

class Details extends StatelessWidget {
  final String title;
  final String imageURL;

  Details(this.title, this.imageURL);

  

  _showWarningDialog(BuildContext context) {
  
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DELETE ITEM'),
            content: Text('are you sure?'),
            actions: <Widget>[
              FlatButton(
                child: Text('CONFIRM'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 10.0,
            title: Text(title),
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              Image.asset('assets/img.jpg'),
              Container(padding: EdgeInsets.all(10.0), child: Text(title)),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    splashColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).accentColor,
                    child: Text("DELETE ITEM"),
                    onPressed: () {
                      _showWarningDialog(context);
                    },
                  ))
            ],
          ))),
    );
  }
}
