import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

//peliculas que estan en cine ahora mismo
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
 final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;
 
  return MoviesNotifier(
    fethMoreMovies: fetchMoreMovies
  );
}); 

//peliculas son populares
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
 final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;
 
  return MoviesNotifier(
    fethMoreMovies: fetchMoreMovies
  );
}); 

//peliculas que vendrán proximamente 
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
 final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpcoming;
 
  return MoviesNotifier(
    fethMoreMovies: fetchMoreMovies
  );
}); 

//peliculas top
final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
 final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;
 
  return MoviesNotifier(
    fethMoreMovies: fetchMoreMovies
  );
}); 


// Define el caso de uso que se espera
typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currenPage = 0;
  bool isLoading = false;
  MovieCallback fethMoreMovies;

  MoviesNotifier({required this.fethMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if( isLoading ) return;
    isLoading = true;

    currenPage++;
    final List<Movie> movies = await fethMoreMovies(page: currenPage);
    state = [...state, ...movies];
    
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
