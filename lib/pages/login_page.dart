import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/widgets/my_btn.dart';

class LoginPage extends StatefulWidget {
  static final routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNodePassword = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey();

  String _email = '', _password = '';

  @override
  void dispose() {
    _focusNodePassword.dispose();
    super.dispose();
  }

  _submit() {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      
    }
  }

  String _validateEmail(String email) {
    if (email.isNotEmpty && email.contains("@")) {
      _email = email;
      return null;
    }
    return "invalid email";
  }

  String _validatePassword(String password) {
    if (password.isNotEmpty && password.length > 4) {
      _password = password;
      return null;
    }
    return "invalid password";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300, minWidth: 200),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "example.@domain.com", labelText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      onFieldSubmitted: (String text) {
                        _focusNodePassword.nextFocus();
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "***********", labelText: "Password"),
                      obscureText: true,
                      focusNode: _focusNodePassword,
                      keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.send,
                      validator: _validatePassword,
                      onFieldSubmitted: (String text) {
                        _submit();
                      },
                    ),
                    SizedBox(height: 30),
                    MyBtn(
                      fullWidth: true,
                      label: "INGRESAR",
                      onPressed: _submit,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      )),
    );
  }
}
