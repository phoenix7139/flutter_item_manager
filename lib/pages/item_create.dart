import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('SAVE'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Text('TEST MODAL SHEET'),
              );
            }
          );
        },
      ),
    );
  }
}
