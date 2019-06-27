import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main_scoped_model.dart';
import '../models/auth_mode.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  String _acceptTermsError = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.LoginMode;

  Widget _emailTextField() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'email ID',
        // filled: true,
        // fillColor: Colors.white.withOpacity(0.2),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordTextController,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'password',
        // filled: true,
        // fillColor: Colors.white.withOpacity(0.2),
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password too short';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _passwordConfirmTextField() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'confirm password',
        // filled: true,
        // fillColor: Colors.white.withOpacity(0.2),
      ),
      obscureText: true,
      validator: (String value) {
        if (value != _passwordTextController.text) {
          return 'Passwords don not match';
        }
      },
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/altLoginImg.jpg'),
      // colorFilter: ColorFilter.mode(
      // Colors.grey.withOpacity(0.6), BlendMode.dstATop)
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('ACCEPT TERMS'),
    );
  }

  void _submitForm(_authenticateUser) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (!_formData['acceptTerms']) {
      setState(() {
        _acceptTermsError = 'SELECT TO PROCEED';
      });
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> successInfo = await _authenticateUser(
        _formData['email'], _formData['password'], _authMode);

    if (successInfo['success'] == true) {
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('an error occured'),
              content: Text(successInfo['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('OKAY'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _targetWidth = MediaQuery.of(context).size.width > 550.0
        ? 500.0
        : MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //     child: Text('LOGIN PAGE'),
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: _targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _emailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _passwordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.SignupMode
                        ? _passwordConfirmTextField()
                        : Container(),
                    _buildAcceptSwitch(),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        _acceptTermsError,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'switch to ${_authMode == AuthMode.LoginMode ? 'signup' : 'login'}',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _authMode = _authMode == AuthMode.LoginMode
                                  ? AuthMode.SignupMode
                                  : AuthMode.LoginMode;
                            });
                          },
                        ),
                        ScopedModelDescendant<MainModel>(
                          builder: (BuildContext context, Widget child,
                              MainModel model) {
                            return model.isLoading
                                ? Container(
                                    padding: EdgeInsets.only(right: 20),
                                    child: CircularProgressIndicator())
                                : FlatButton(
                                    splashColor: Theme.of(context).accentColor,
                                    child: Text(
                                      '${_authMode == AuthMode.LoginMode ? 'LOGIN' : 'SIGNUP'}',
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    onPressed: () =>
                                        _submitForm(model.authenticate),
                                  );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
