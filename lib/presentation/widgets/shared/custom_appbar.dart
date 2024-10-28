import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              IconButton(onPressed: () {

                // Creamos una funcion para hacer referencia 
                final movieRepository =  ref.read(movieRepositoryProvider);


                // Realizamos la busqueda
                showSearch(
                  context: context, 
                  delegate: SearchMovieDelegate(
                    searchMovies: movieRepository.searchMovies
                  )
                );
              },
              icon:const Icon (Icons.search)
              )
            ],
          ),
         ), ) 
      );
  }
}