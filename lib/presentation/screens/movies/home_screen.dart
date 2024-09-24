import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

// para cargar la primera pagina convertimos a un COnsumerFUL
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
// Llamamos las paginas
  @override
  void initState() {
    super.initState();
    // Hacemos el llamado al provider
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading) return const FullScreenLoader();

    // Listado de peliculas
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero,
          ),

        ),

      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppbar(),
            MoviesSlideshow(movies: moviesSlideshow),

            // peliculas en cine
            MovieHorizontalListviw(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Lunes 21',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),

            // Peliculas que estaran proximante en cines
            MovieHorizontalListviw(
              movies: upcomingMovies,
              title: 'Próximamente',
              subTitle: 'Este mes',
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              },
            ),

            // Peliculas populares
            MovieHorizontalListviw(
              movies: popularMovies,
              title: 'Populares',
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),

            // Peliculas mejores calificadas
            MovieHorizontalListviw(
              movies: topRatedMovies,
              title: 'Mejores calificadas',
              subTitle: 'Desde siempre',
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
