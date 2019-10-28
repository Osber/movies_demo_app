import 'package:flutter/material.dart';
import 'dart:async';
import 'package:movies_demo_app/api/models/models.dart';
import 'package:movies_demo_app/components/dark_backgroud.dart';
import 'package:movies_demo_app/components/menu_drawer.dart';
import 'package:movies_demo_app/providers/providers.dart';
import 'package:provider/provider.dart';
import 'movie_list_screen/movie_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<MovieModel>> future;

  @override
  Widget build(BuildContext context) {
    final moviesBloc = Provider.of<MoviesBloc>(context);
    if (future == null) future = moviesBloc.getList();

    return FutureBuilder<List<MovieModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DarkBackgroud(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final movies = snapshot.data ?? [];
          if (moviesBloc.page == 0) moviesBloc.movieModel = movies[0];
          return DarkBackgroud(
              child: Scaffold(
                  endDrawer: MenuDrawer(),
                  body: Container(
                    child: MoviesListScreen(
                      items: movies,
                    ),
                  )));
        });
  }
}
