import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      // Rutas hijas
      routes: [
        // Enviamos el ID como argumento
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieID = state.pathParameters['id'] ?? 'no-ID';

              return MovieScreen(movieID: movieID);
            }),
      ]),
]);
