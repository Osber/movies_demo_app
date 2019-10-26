import 'package:flutter/material.dart';
import 'package:movies_demo_app/components/dark_backgroud.dart';
import 'package:movies_demo_app/screens/Login/login_form.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DarkBackgroud(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Movies App',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Center(
                  child: LoginForm(),
                ),
                LoginForgotPasswordButton(),
                LoginSingUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Center(
        child: InkWell(
          onTap: () => Navigator.of(context),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  color: Colors.white, decoration: TextDecoration.underline),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginSingUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Center(
        child: InkWell(
          onTap: () => Navigator.of(context),
          child: Container(
              padding: EdgeInsets.all(5.0),
              child: RichText(
                text: TextSpan(text: "Don't have and account? ", children: [
                  TextSpan(
                    text: 'Sign UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
