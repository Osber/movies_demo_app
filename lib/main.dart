import 'package:flutter/material.dart';
import 'package:movies_demo_app/components/dark_backgroud.dart';
import 'package:movies_demo_app/screens/Login/login_screen.dart';
import 'package:movies_demo_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies_demo_app/providers/providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppProvider(
        child: RootPage(),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    final accountBloc = Provider.of<AccountBloc>(context);

    switch (accountBloc.status) {
      case AuthStatus.NOT_DETERMINED:
        return DarkBackgroud(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginScreen();
        break;
      case AuthStatus.LOGGED_IN:
        return HomeScreen();
        break;
      default:
        return DarkBackgroud(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
