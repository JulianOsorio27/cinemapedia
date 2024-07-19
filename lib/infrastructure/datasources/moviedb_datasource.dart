// Este archivo esta especializado en el datasource de movidb

// Esta clase extiende el origen de datos moviesDatasource que es como lucen los datos
import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movidb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  // Con esta instancia podemos realizar peticiones http usando dio
  final dio = Dio(BaseOptions(
      // Todas las peticiones empiezan con este url
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-Mx'
      }));

  // Esta función regresa la cartelera que hoy esta en cine
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    // Listado de peliculas
    final List<Movie> movies =  movieDBResponse.results
    //el where condiciona para que no se muestre la pelicula si el poster no existe
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    //Si pasa el condicional se muestra la pelicula
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
}
