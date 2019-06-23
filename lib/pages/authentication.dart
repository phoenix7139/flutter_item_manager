import 'package:flutter/material.dart';

// import 'home.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('LOGIN'),
      )),
      body: Center(
        child: RaisedButton(
          child: Text('LOGIN'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
    );
  }
}
