

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movidb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity( Cast cast ) => 
  Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
    ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
    : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
    character: cast.character,
  ); 

}