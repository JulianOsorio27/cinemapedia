import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListviw extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;


  const MovieHorizontalListviw({
    super.key, 
    required this.movies, 
    this.title, 
    this.subTitle,
    this.loadNextPage
    });

  @override
  State<MovieHorizontalListviw> createState() => _MovieHorizontalListviwState();
}

class _MovieHorizontalListviwState extends State<MovieHorizontalListviw> {

  // Definimos el scroll para controlar el movimiento
  final scrollControler = ScrollController();

  // Escuhamos los cambios 
  @override
  void initState() {
    super.initState();
    scrollControler.addListener( () {

      if (widget.loadNextPage == null ) null;

      if ( (scrollControler.position.pixels + 200) >= scrollControler.position.maxScrollExtent ) {
     
        widget.loadNextPage!();
      }
    });

  }

  // Cancelamos el escuchar
  @override
  void dispose() {
    scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if( widget.title != null || widget.subTitle != null )
          _Title(title: widget.title, subTitle: widget.subTitle,),

          // Mostramos las peliculas en un listView
          Expanded(
            child:  ListView.builder(
              controller: scrollControler,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: widget.movies[index]
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [

          //* IMAGEN
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2
                        ),
                      ),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          // *TITULO
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                const SizedBox(width: 3),
                Text('${ movie.voteAverage }', style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                // const SizedBox(width: 10,),
                // Text('${movie.popularity}', style: textStyle.bodySmall ,)
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall )
              ],
            ),
          )
          
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({
    this.title,
    this.subTitle});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if( title != null )
          Text(title!, style: titleStyle ),
          const Spacer(),

          if( subTitle != null )
          FilledButton(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: () {},
            child: Text(subTitle! )
            )


        ],
      ),
    );
  }
}