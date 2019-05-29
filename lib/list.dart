import 'package:flutter/material.dart';

class BucketList extends StatelessWidget {
  final List<String> bucketlist;

  BucketList(this.bucketlist); 

  @override
  Widget build(BuildContext context) {
    return Column(
                children: bucketlist
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/img.jpg'),
                              Text(element)
                            ],
                          ),
                        ))
                    .toList());
  }
}