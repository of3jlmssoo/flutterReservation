import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/appbarcomp.dart';
import 'package:reservations2/commonclass.dart';
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
      log.info('isLoggedIn $isLoggedIn currentUser ${authRepository.currentUser}  path is $path');
      if (isLoggedIn) {
        if (path.startsWith('/facilityselection')) return '/facilityselection';
        if (path.startsWith('/dateselection')) return '/dateselection';
        if (path.startsWith('/datetimepickerapp')) return '/datetimepickerapp';
        if (path.startsWith('/reservationinput')) return '/reservationinput';
        if (path.startsWith('/reservationconfirmation')) return '/reservationconfirmation';
        if (path.startsWith('/reservationstatus')) return '/reservationstatus';
        if (path.startsWith('/reservationdetails')) return '/reservationdetails';
        if (path.startsWith('/usagestatus')) return '/usagestatus';
        if (path.startsWith('/usagedetails')) return '/usagedetails';
        if (path.startsWith('/userinformation')) return '/userinformation';
        if (path.startsWith('/userinformationupdate')) return '/userinformationupdate';
        if (path.startsWith('/firestorework')) return '/firestorework';
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
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/facilityselection',
        builder: (context, state) => const FacilitySelectionScreen(),
      ),
      GoRoute(
        path: '/dateselection',
        builder: (context, state) => DateSelectionScreen(
          facility: state.extra! as String,
        ),
      ),
      GoRoute(
        path: '/datetimepickerapp',
        builder: (context, state) => const DatePickerApp(),
      ),
      GoRoute(
        path: '/firestorework',
        builder: (context, state) => const Firestorework(),
      ),
      GoRoute(
        path: '/reservationinput',
        builder: (context, state) => ReservationInputScreen(
          rbase: state.extra! as ReservationInputsBase,
        ),
      ),
      GoRoute(
        path: '/reservationconfirmation',
        builder: (context, state) => ReservationConfirmationScreen(
          rext: state.extra! as ReservationInputsExt,
        ),
      ),
      GoRoute(path: '/reservationstatus', builder: (context, state) => const UsageStatusScreen()),
      GoRoute(
        path: '/reservationdetails',
        builder: (context, state) => UsageDetailsScreen(
          id: state.extra! as String,
        ),
      ),
      GoRoute(path: '/usagestatus', builder: (context, state) => const UsageStatusScreen()),
      GoRoute(
        path: '/usagedetails',
        builder: (context, state) => UsageDetailsScreen(
          id: state.extra! as String,
        ),
      ),
      GoRoute(path: '/userinformation', builder: (context, state) => UserInformationScreen(user: state.extra! as User)),
      GoRoute(
        path: '/userinformationupdate',
        builder: (context, state) => UserInformationUpdateScreen(
          user: state.extra! as User,
        ),
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
