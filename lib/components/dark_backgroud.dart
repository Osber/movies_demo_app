import 'package:flutter/material.dart';

class DarkBackgroud extends StatelessWidget {
  final Widget child;
  DarkBackgroud({this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0, 1],
              colors: <Color>[
                Color(0xFF606060),
                Colors.black,
              ],
            ),
          ),
        ),
        child
      ],
    );
  }
}
