import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Import our files
import 'data/repositories/album_repository.dart';
import 'business_logic/bloc/album_bloc.dart';
import 'presentation/screens/album_list_screen.dart';
import 'presentation/screens/album_detail_screen.dart';
import 'data/models/album_with_photo.dart';

// Main function - entry point of the app
void main() {
  print('Starting Album Viewer app');

  runApp(MyApp());
}

// Root widget of our app
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AlbumRepository _repository = AlbumRepository();

  // Set up router for navigation
  late final GoRouter _router = GoRouter(
    routes: [
      // Home route - shows album list
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          // Create the AlbumBloc
          create: (context) => AlbumBloc(repository: _repository),
          child: const AlbumListScreen(),
        ),
      ),
      // Detail route - shows album details
      GoRoute(
        path: '/album/:id',
        builder: (context, state) {
          // Get album data from route
          final albumWithPhoto = state.extra as AlbumWithPhoto;
          return AlbumDetailScreen(albumWithPhoto: albumWithPhoto);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Album Viewer',
      // Set up the theme with brown colors
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown[50],
      ),
      // Use GoRouter for navigation
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}