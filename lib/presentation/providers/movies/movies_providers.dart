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

// Define el caso de uso que se espera
typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currenPage = 0;
  MovieCallback fethMoreMovies;

  MoviesNotifier({required this.fethMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    currenPage++;
    final List<Movie> movies = await fethMoreMovies(page: currenPage);
    state = [...state, ...movies];
  }
}
