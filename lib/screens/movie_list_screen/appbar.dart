import 'package:flutter/material.dart';
import 'package:movies_demo_app/components/view_utils.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(),
              ),
              Expanded(
                child: Text(
                  'Movies',
                  style: textStyleRegular(fontSize: 26),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 20, 0),
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final scaffoldState = Scaffold.of(context);
                        scaffoldState.openEndDrawer();
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
