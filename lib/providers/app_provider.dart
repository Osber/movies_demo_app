import 'providers.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatefulWidget {
  AppProvider({this.child});

  final Widget child;

  @override
  _AppProviderState createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  AccountBloc accountBloc;
  MoviesBloc moviesBloc;
  @override
  void initState() {
    super.initState();
    accountBloc = AccountBloc();
    moviesBloc = MoviesBloc();
  }

  @override
  void dispose() {
    super.dispose();
    accountBloc.dispose();
    moviesBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: accountBloc),
        ChangeNotifierProvider.value(value: moviesBloc),
      ],
      child: widget.child,
    );
  }
}
