import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_demo_app/components/dark_backgroud.dart';
import 'login_email_text_field.dart';
import 'package:provider/provider.dart';
import 'package:movies_demo_app/providers/providers.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  String email;
  bool isSent = false;

  Widget _buildScreen() {
    if (isSent) {
      return MailSent(email: email);
    } else if (email == null) {
      return RecoveryForm(
        onDone: (text) => setState(() => email = text),
      );
    } else {
      return SendMailDialog(
        onCancel: () => setState(() => email = null),
        onDone: () async {
          final accountBloc = Provider.of<AccountBloc>(context);
          await accountBloc.resetPassword(email);
          setState(() => isSent = true);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DarkBackgroud(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                child: Container(),
                flex: 3,
              ),
              Text(
                'Reset password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              _buildScreen(),
              Expanded(child: Container(), flex: 3),
              SizedBox(height: 32),
            ],
          )
        ],
      ),
    );
  }
}

class RecoveryForm extends StatefulWidget {
  final void Function(String email) onDone;
  RecoveryForm({this.onDone});
  @override
  _RecoveryFormState createState() => _RecoveryFormState();
}

class _RecoveryFormState extends State<RecoveryForm> {
  TextEditingController controller;
  FocusNode focus;
  bool isValidEmail = false;

  @override
  void initState() {
    super.initState();
    focus = FocusNode();
    controller = TextEditingController(text: "")..addListener(_verifyEmail);
  }

  void _verifyEmail() {
    final isEmail = emailPattern.hasMatch(controller.text);
    final isEmpty = controller.text == "";
    final hasInvalidChar = controller.text.indexOf(RegExp(r'[,\s\t]')) != -1;
    final bool isValid = isEmail && !isEmpty && !hasInvalidChar;
    if (isValidEmail != isValid) setState(() => isValidEmail = isValid);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Text(
            'Insert your email, we will send you the next steps',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 170,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(10.0)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                LoginEmailTextField(
                  hintText: 'email@example.com',
                  controller: controller,
                  focusNode: focus,
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 42.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: isValidEmail
                            ? () => widget.onDone(controller.text)
                            : null,
                        child: Container(
                          height: 42.5,
                          decoration: BoxDecoration(
                            color: isValidEmail ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Center(
                            child: Text(
                              'Ok',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MailSent extends StatelessWidget {
  const MailSent({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'The email has been sent to ',
            style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Text(email,
            style: TextStyle(
              height: 1.5,
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
        SizedBox(
          height: 15,
        ),
        Text(
          'Dont forget to check your spam!',
          style: TextStyle(
            height: 1.5,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: 42.5,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                'Go to login',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SendMailDialog extends StatefulWidget {
  const SendMailDialog({this.onDone, this.onCancel});

  final Future<void> Function() onDone;
  final void Function() onCancel;

  @override
  _SendMailDialogState createState() => _SendMailDialogState();
}

class _SendMailDialogState extends State<SendMailDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: CupertinoAlertDialog(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            'Send reset password email?',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: widget.onCancel,
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              setState(() => isLoading = true);
              await widget.onDone();
              setState(() => isLoading = false);
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
