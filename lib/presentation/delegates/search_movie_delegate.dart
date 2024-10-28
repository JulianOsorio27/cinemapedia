import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

// Definicion de como debe lucir la busqueda de peliculas
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

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
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:  (context, index) {

            return _MovieItem(movie: movies[index] );           
            
          }   
         );
      },
    );
  }
}


class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [

          // Iamgen
          SizedBox( 
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
                : Text(movie.overview)
              ],
            ),
          )

        ]
      ),

    );
  }
}
