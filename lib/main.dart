import 'package:flutter/material.dart';

import './item_adder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BucketList'),
        ),
        body: ItemAdder(),
      ),
    );
  }
}
