
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;


    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SizedBox( 
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox( width: 5, ),
              Text('Cinemapedia', style: titleStyle,),

              //Envia el proximo elemento al final con el espacio disponible
              const Spacer(),
              IconButton(onPressed: ()  {

                // Creamos una funcion para hacer referencia 
                final searchMovies =  ref.read( searchMoviesProvider );
                final searchQuery = ref.read(  searchQueryProvider );



                // Realizamos la busqueda
               showSearch<Movie?>(
                  query: searchQuery,
                  context: context, 
                  delegate: SearchMovieDelegate(
                    initialMovies: searchMovies,
                    searchMovies: ref.read(searchMoviesProvider.notifier ).searchMoviesByQuery
                     

                  )
                  // Navegamos a la pelicula seleccionada
                ).then((movie) {
                  if (movie == null) return;

                  if (context.mounted) {
                    
                  context.push('/movie/${movie.id}');
                  
                  }
                  
                });
              }, 

              icon:const Icon (Icons.search)
              )
            ],
          ),
         ), ) 
      );
  }
}