import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/getting_started/presentation/screens/getting_started_screen.dart';
import '../../features/now_playing/presentation/screens/now_playing_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const GettingStartedScreen(),
      ),
      GoRoute(
        path: '/explore',
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: '/now-playing',
        builder: (context, state) {
          final extra = state.extra;

          if (extra is Map<String, dynamic> &&
              extra.containsKey('image') &&
              extra.containsKey('title') &&
              extra.containsKey('author') &&
              extra.containsKey('audioUrl')) {
            return NowPlayingScreen(
              image: extra['image'],
              title: extra['title'],
              author: extra['author'],
              audioUrl: extra['audioUrl'],
            );
          }

          return const Scaffold(
            body: Center(
              child: Text(
                'Invalid data for Now Playing',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

    ],
  );
}
