import 'package:flutter/material.dart';
import 'package:movies_demo_app/components/view_utils.dart';
import 'package:movies_demo_app/components/genres_view.dart';
import 'package:movies_demo_app/providers/providers.dart';

import 'package:provider/provider.dart';

class MovieItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesBloc = Provider.of<MoviesBloc>(context);
    final double distortionValue = Curves.linear
        .transform(distortionBasedOnPage(moviesBloc.page, moviesBloc.index));

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final titleHeight = constraints.maxHeight / 2.5;
      return Transform.scale(
        scale: distortionValue,
        child: Opacity(
            opacity: distortionValue,
            child: addMargin(
              left: 32,
              right: 32,
              child: Column(
                key: ValueKey(moviesBloc.movie.title),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  addMargin(
                    top: 8,
                    child: Genres(),
                  ),
                  Hero(
                    tag: moviesBloc.movie.title,
                    child: Container(
                      height: titleHeight,
                      child: addMargin(
                        top: 8,
                        child: Text(
                          moviesBloc.movie.title,
                          maxLines: 2,
                          style: textStyleMedium(fontSize: titleHeight / 3),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.white),
                      addMargin(
                          left: 8,
                          child: Text(
                            moviesBloc.movie.voteAverage.toString(),
                            maxLines: 2,
                            style: textStyleLight(fontSize: 25),
                          ))
                    ],
                  )
                ],
              ),
            )),
      );
    });
  }
}
