import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> _bucketlist = ['first entry'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BucketList'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _bucketlist.add('new entry');
                });
              },
                  
                child: Text('add entry'),
              ),
            ),
            Column(
                children: _bucketlist
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/img.jpg'),
                              Text(element)
                            ],
                          ),
                        ))
                    .toList())
          ],
        ),
      ),
    );
  }
}
