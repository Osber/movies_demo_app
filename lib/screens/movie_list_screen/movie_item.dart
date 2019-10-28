import 'package:flutter/material.dart';
import 'package:movies_demo_app/api/models/models.dart';
import 'package:movies_demo_app/components/movie_card.dart';
import 'package:movies_demo_app/components/view_utils.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;
  final List<Genre> genres;

  const MovieItem({Key key, this.movie, this.genres}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieItemState();
}

class MovieItemState extends State<MovieItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;
    return addSymetricMargin(
        horizontal: 5,
        child: Material(
          color: Colors.transparent,
          child: Transform.scale(
            scale: scale,
            child: MovieCard(
              urlImage: widget.movie.backdropPath,
              radius: 20,
              hasShadow: true,
            ),
          ),
        ));
  }
}
