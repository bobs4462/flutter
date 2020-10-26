import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function({
    String email,
    String userName,
    String pass,
    bool isLogin,
    BuildContext ctx,
  }) onSubmit;
  AuthForm(this.onSubmit, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String _email;
  String _userName;
  String _pass;
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  void trySubmit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSubmit(
        email: _email.trim(),
        userName: _userName,
        pass: _pass.trim(),
        ctx: context,
        isLogin: _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(19.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _email = value;
                    },
                    validator: (String text) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text)) {
                        return null;
                      }
                      return 'Invalid email address';
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      onSaved: (value) {
                        _userName = value;
                      },
                      validator: (String text) {
                        if (text.isEmpty || text.length < 6) {
                          return 'User name cannot be less than 6 chars';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'User name'),
                    ),
                  TextFormField(
                    key: ValueKey('pass'),
                    onSaved: (value) {
                      _pass = value;
                    },
                    validator: (String text) {
                      if (text.isEmpty || text.length < 8) {
                        return 'User password cannot be less than 8 chars';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 13),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: trySubmit,
                      child: Text(_isLogin ? 'Login' : 'SignUp'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      child: Text(_isLogin ? 'Create an account' : 'Login'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
