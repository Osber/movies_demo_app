import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'login_email_text_field.dart';

typedef void ParametersCallback(Map<String, dynamic> profile);

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

enum _FocusTime { never, first, many }

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _userController;
  TextEditingController _passController;

  FocusNode _userFocus;
  FocusNode _passFocus;
  _FocusTime _userFocusTime;
  _FocusTime _passFocusTime;

  bool _hasUserTriedToLogin = false;

  bool _hasUserError = true;
  bool _hasPassError = true;

  bool get _isLoginDisabled => _hasUserError || _hasPassError;

  @override
  void initState() {
    super.initState();
    _userFocusTime = _FocusTime.never;
    _passFocusTime = _FocusTime.never;

    _userController = TextEditingController(text: '')
      ..addListener(_verifyUsername);
    _passController = TextEditingController(text: '')
      ..addListener(_verifyPassword);

    _userFocus = FocusNode();
    _passFocus = FocusNode();

    _userFocus.addListener(() {
      _userFocusTime = _nextFocusTime(_userFocusTime);
    });

    _passFocus.addListener(() {
      _passFocusTime = _nextFocusTime(_passFocusTime);
    });
  }

  _FocusTime _nextFocusTime(_FocusTime focusTime) {
    switch (focusTime) {
      case _FocusTime.first:
        //print("from First to Many");
        return _FocusTime.many;
        break;
      case _FocusTime.many:
        //print("from Many to Many");
        return _FocusTime.many;
        break;
      case _FocusTime.never:
      default:
        //print("from Never to First");
        return _FocusTime.first;
        break;
    }
  }

  void _verifyUsername() {
    final isEmail = emailPattern.hasMatch(_userController.text);
    final isEmpty = _userController.text == "";
    final hasInvalidChar =
        _userController.text.indexOf(RegExp(r'[,\s\t]')) != -1;
    setState(() {
      if (_userFocusTime != _FocusTime.never && isEmpty) {
        _userFocusTime = _FocusTime.first;
      } else if (hasInvalidChar) {
        _userFocusTime = _FocusTime.many;
      }
      //_hasUserError = !isEmail || isEmpty || hasInvalidChar;
      _hasUserError = !isEmail || hasInvalidChar;
    });
  }

  void _verifyPassword() =>
      setState(() => _hasPassError = _passController.text == "");

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    _userFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*   final accountbloc = Provider.of<AccountBloc>(context); */
    return SizedBox(
      width: double.infinity,
      height: 334,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(10.0)),
            color: Colors.white),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: _userFocusTime == _FocusTime.many && _hasUserError
                      ? Text(
                          'Insert a valid email',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.start,
                        )
                      : Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF909091),
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                ),
              ),
              LoginEmailTextField(
                hintText: 'email@example.com',
                controller: _userController,
                focusNode: _userFocus,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                  //child: _passFocusTime == _FocusTime.many && _hasPassError
                  child: _hasUserTriedToLogin
                      ? Text(
                          'Insert a password',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.start,
                        )
                      : Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xFF909091),
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                ),
              ),
              LoginPasswordTextField(
                hintText: "Password",
                controller: _passController,
                focusNode: _passFocus,
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      if (_passController.text.length == 0) {
                        return setState(() => _hasUserTriedToLogin = true);
                      }
                      /*      accountbloc
                          .login(
                        email: _userController.text,
                        password: _passController.text,
                      )
                          .catchError((error) {
                        showDialog(
                            context: context, builder: (_) => LoginError());
                      }); */
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: _isLoginDisabled
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.blue,
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "Login error",
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
      ),
      content: Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Text("Wrong email or password.",
            style: TextStyle(
              color: Colors.grey,
            )),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Ok"),
          textStyle: TextStyle(color: Colors.blue),
        )
      ],
    );
  }
}

class LoginPasswordTextField extends StatelessWidget {
  LoginPasswordTextField({this.controller, this.hintText, this.focusNode});

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE3EEF5), //f3fcff
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.blueAccent,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
