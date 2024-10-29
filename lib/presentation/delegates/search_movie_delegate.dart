import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

// Definicion de como debe lucir la busqueda de peliculas
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;


  SearchMovieDelegate({required this.searchMovies});

  void _onQueryChanged (String query) { 
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration( milliseconds: 500), () {} );
  }


  @override
  String get searchFieldLabel => 'Buscar Película';

  // Construye las acciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // if( query.isNotEmpty )
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      )
    ];
  }

  // Construye la parte del inicio
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  // Resultados cuando se presiona enter
  @override
  Widget buildResults(BuildContext context) {
    return const Text('data');
  }

  // Cuando la persona escribe la busqueda
  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return StreamBuilder(
      // future: searchMovies(query),
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:  (context, index) {

            return _MovieItem(
              movie: movies[index],
              onMovieSelected: close,
             );           
            
          }   
         );
      },
    );
  }
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({ required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected( context, movie  );
      },
      child: Padding(
        padding: const  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
      
            // Iamgen
            SizedBox( 
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.posterPath, loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child), ),
              ),
             ),
      
      
             const  SizedBox(width: 10),
      
      
            // Descripción
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium, ),
                  ( movie.overview.length >100 )
                  ? Text( '${movie.overview.substring(0,100)}...' )
                  : Text(movie.overview),
      
                  // Calificacion 
                  Row(
                    children : [
                      Icon( Icons.star_half_rounded, color: Colors.yellow.shade800,  ),
                      const   SizedBox(width: 5),
                      Text( HumanFormats.number(movie.voteAverage, 1), 
                      style: textStyle.bodyMedium!.copyWith( color:Colors.yellow.shade800 ) ,)
                    ]
      
                  )
                ],
              ),
            )
      
          ]
        ),
      
      ),
    );
  }
}
