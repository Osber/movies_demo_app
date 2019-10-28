import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_demo_app/providers/providers.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountBloc = Provider.of<AccountBloc>(context);
    final moviesBloc = Provider.of<MoviesBloc>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: Drawer(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: <Color>[
              Color(0xFF606060),
              Colors.black87,
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            DrawerTile(
              title: "Log out",
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onTap: () async {
                try {
                  moviesBloc.page = 0;
                  moviesBloc.index = 0;
                  await accountBloc.signOut();
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(e.toString()),
                          ));
                }
              },
            )
          ],
        ),
      )),
    );
  }
}

class DrawerTile extends StatelessWidget {
  DrawerTile({this.title, this.icon, this.onTap});
  final Icon icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
