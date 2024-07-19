// Aqui llamamos al datasource

import 'package:cinemapedia/domain/entities/movie.dart';

// Se define como luce los origines de datos, metodos que se usaran para llamar la data
abstract class MoviesRepository {


// Reguresa las peliculas que estan actulamente en cartelera --- Solo implementamos
// Será una lista que a futuro me regrese una movi, por parametro será siempre paginado 
Future<List<Movie>> getNowPlaying ( { int page = 1 } );

}