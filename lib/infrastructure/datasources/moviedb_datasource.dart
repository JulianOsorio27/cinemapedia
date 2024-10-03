// Este archivo esta especializado en el datasource de movidb

// Esta clase extiende el origen de datos moviesDatasource que es como lucen los datos
import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movidb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/models/movidb/moviedetails.dart';
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

//  Este método recibe un JSON con datos de películas, lo convierte en una lista
// de objetos Movie, filtra aquellas películas que no tienen poster,
// y devuelve una lista de películas que cumplen con los criterios.
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    // Listado de peliculas
    final List<Movie> movies = movieDBResponse.results
        //el where condiciona para que no se muestre la pelicula si el poster no existe
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        //Si pasa el condicional se muestra la pelicula
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  // Esta función regresa la cartelera que hoy esta en cine
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);    
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovies(response.data); 
  }
  
  @override
  Future<Movie> getMovieId(String id) async {
    final response =
        await dio.get('/movie/$id');
    if( response.statusCode != 200 ) throw Exception('La pelicula con el ID: $id no se encontro');  

    final movieDetails = MovieDetails.fromJson(response.data);  

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);


    return movie;
  }
}
