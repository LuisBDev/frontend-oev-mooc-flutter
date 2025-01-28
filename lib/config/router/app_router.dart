import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/config/router/app_router_notifier.dart';
import 'package:oev_mobile_app/presentation/screens/login/check_auth_status_screen.dart';
import 'package:oev_mobile_app/presentation/screens/login/login_screen.dart';
import 'package:oev_mobile_app/presentation/screens/login/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/screens/register/register_screen.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: RegisterScreen.name,
        builder: (context, state) => const RegisterScreen(),
      )
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') {
          return null;
        }

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash') {
          return '/home';
        }
      }

      return null;
    },
  );
});
