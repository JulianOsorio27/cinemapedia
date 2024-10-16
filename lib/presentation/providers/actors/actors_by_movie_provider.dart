
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final  actorByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {

  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors:  actorsRepository.getActorsBymovie);



});



// Definicion del callback
typedef GetActorsCallback  = Future<List<Actor>> Function( String movieId );


class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {

  final GetActorsCallback getActors;
  
  
  ActorsByMovieNotifier({
    required  this.getActors,

  }): super({});

  Future<void> loadActors ( String movieId ) async {

    if( state [movieId]  != null ) return;

    final List<Actor> actor = await getActors( movieId );

    state  = {...state, movieId: actor};


  }




}