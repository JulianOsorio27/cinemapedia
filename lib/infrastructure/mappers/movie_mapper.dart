// Este archivo se encarga de leer diferentes modelos y crear mi ENTIDAD

//Importaciones
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movidb/movie_moviedb.dart';

//Crea una pelicula basado en algun objeto que vamos a recibir
class MovieMapper {
  //Creamos una instancia de MovieMovieDB
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '' )
      ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
      : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '' )
      ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
      : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
