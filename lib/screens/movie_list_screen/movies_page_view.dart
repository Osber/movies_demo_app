import 'package:flutter/cupertino.dart';
import 'package:movies_demo_app/api/models/models.dart';
import 'package:provider/provider.dart';
import 'package:movies_demo_app/components/view_utils.dart';
import 'package:movies_demo_app/components/custom_page_view.dart';
import 'movie_item.dart';
import 'package:movies_demo_app/providers/providers.dart';

class MoviesPageView extends StatelessWidget {
  final List<MovieModel> items;

  const MoviesPageView({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesBloc = Provider.of<MoviesBloc>(context);

    if (items.length == 0)
      return Text('No Results', style: textStyleMedium(fontSize: 24));
    else {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final marginTop = 16.0;

        return addMargin(
          top: marginTop,
          child: CustomPageView(
            height: constraints.maxHeight - marginTop,
            onPageChanged: (newIndex) {
              moviesBloc.index = newIndex;
              moviesBloc.movieModel = items[newIndex];
            },
            onPageScrolled: (newPage) {
              moviesBloc.page = newPage;
            },
            children: items.map((item) {
              return addSymetricMargin(
                horizontal: 10,
                vertical: 5,
                child: Hero(
                  tag: item.movie.posterPath,
                  child: MovieItem(
                    key: ValueKey(item.movie),
                    movie: item.movie,
                    genres: item.genres,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      });
    }
  }
}
