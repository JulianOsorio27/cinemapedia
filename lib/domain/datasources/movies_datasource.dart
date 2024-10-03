import 'package:cinemapedia/domain/entities/movie.dart';


// Origenes de datos 


// Se define como luce los origines de datos, metodos que se usaran para llamar la data
abstract class MoviesDatasource {


// Regresa las peliculas que estan actulamente en cartelera --- Solo definimos el contrato
// Será una lista que a futuro me regrese una lista de movies, por parametro será siempre paginado 
Future<List<Movie>> getNowPlaying ( { int page = 1 } );
Future<List<Movie>> getPopular ( { int page = 1 } );
Future<List<Movie>> getUpcoming ( { int page = 1 } );
Future<List<Movie>> getTopRated ( { int page = 1 } );

// Regresa una movie por el ID
Future<Movie> getMovieId ( String id );

}