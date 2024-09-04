import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/datepickerapp.dart';
import 'package:reservations2/screens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firebase_auth_repository.dart';
import 'go_router_refresh_stream.dart';

part 'app_router.g.dart';

final log = Logger('app_router');

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  // rebuild GoRouter when app startup state changes
  // final appStartupState = ref.watch(appStartupProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final path = state.uri.path;

      final isLoggedIn = authRepository.currentUser != null;
      log.info('isLoggedIn $isLoggedIn');
      log.info('currentUser ${authRepository.currentUser}');
      log.info('path is $path');
      if (isLoggedIn) {
        if (path.startsWith('/newreservation')) return '/newreservation';
        if (path.startsWith('/facilityselection')) return '/facilityselection';
        if (path.startsWith('/datetimepickerapp')) return '/datetimepickerapp';

        return '/main';
      } else {
        return '/login';
      }
      // return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/main',
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/newreservation',
        builder: (context, state) => NewReservationScreen(),
      ),
      GoRoute(
        path: '/facilityselection',
        builder: (context, state) => FacilitySelectionScreen(
          facility: state.extra! as String,
        ),
      ),
      GoRoute(
        path: '/datetimepickerapp',
        builder: (context, state) => DatePickerApp(),
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
