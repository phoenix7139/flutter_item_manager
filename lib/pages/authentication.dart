import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text('LOGIN PAGE'),
        )),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/loginImg.jpg'),
              // colorFilter: ColorFilter.mode(
              // Colors.grey.withOpacity(0.6), BlendMode.dstATop)
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'email ID',
                  // filled: true,
                  // fillColor: Colors.white.withOpacity(0.2),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  setState(() {
                    _emailValue = value;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'password',
                  // filled: true,
                  // fillColor: Colors.white.withOpacity(0.2),
                ),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _passwordValue = value;
                  });
                },
              ),
              SwitchListTile(
                value: _switchValue,
                onChanged: (bool value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
                title: Text('ACCEPT TERMS'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  splashColor: Theme.of(context).accentColor,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/display');
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
