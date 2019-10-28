import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_demo_app/api/models/models.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'movies_page_view.dart';
import 'movie_item_details.dart';
import 'package:movies_demo_app/components/view_utils.dart';
import 'package:movies_demo_app/providers/providers.dart';

class MoviesListScreen extends StatefulWidget {
  final List<MovieModel> items;

  const MoviesListScreen({this.items});

  @override
  State<StatefulWidget> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  int selectedMovie;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      lowerBound: 0.8,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final moviesBloc = Provider.of<MoviesBloc>(context);

    return ScaleTransition(
      scale: animation,
      child: Stack(children: <Widget>[
        backgroundImage(
            height: height,
            movie:
                moviesBloc.movie == null ? widget.items[0] : moviesBloc.movie),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(),
            Expanded(
              flex: 3,
              child: MoviesPageView(items: widget.items),
            ),
            Expanded(
              flex: 1,
              child: MovieItemDetails(),
            ),
          ],
        )
      ]),
    );
  }

  backgroundImage({height: double, Movie movie}) {
    return Hero(
      tag: movie.id,
      child: Stack(
        children: <Widget>[
          fadeNetworkImage(
            height: height,
            url: "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
