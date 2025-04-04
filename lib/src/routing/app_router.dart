import 'package:aquaponics/src/features/auth/data/remote_auth_repository.dart';
import 'package:aquaponics/src/features/auth/presentation/account/account_screen.dart';
import 'package:aquaponics/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:aquaponics/src/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:aquaponics/src/features/control/presentation/control/control_panel_screen.dart';
import 'package:aquaponics/src/features/control/presentation/history/history_screen.dart';
import 'package:aquaponics/src/features/monitoring/presentation/dash_board_screen.dart';
import 'package:aquaponics/src/features/monitoring/presentation/notifications_screen.dart';
import 'package:aquaponics/src/routing/go_router_refresh_stream.dart';
import 'package:aquaponics/src/routing/not_found_screen.dart';
import 'package:aquaponics/src/routing/scaffold_with_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashBoardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashBoard');
final _controlPanelNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'controlPanel');
final _historyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'history');
final _notificationsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'notifications');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  onboarding,
  signIn,
  signup,
  forgotPassword,
  dashboard,
  controlPanel,
  automation,
  notifications,
  history,
  deviceSettings,
  appSettings,
  account,
  help,
  contact,
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final user = authRepository.currentUser;
      final isLoggedIn = user != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/';
        }
        final isAdmin = await user.isAdmin();

        if (!isAdmin && path.startsWith('/admin')) {
          return '/';
        }
      } else {
        if (path == '/account' || path == '/orders') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignInScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashBoardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                name: AppRoute.dashboard.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashBoardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _controlPanelNavigatorKey,
            routes: [
              GoRoute(
                path: '/controlPanel',
                name: AppRoute.controlPanel.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ControlPanelScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _historyNavigatorKey,
            routes: [
              GoRoute(
                path: '/history',
                name: AppRoute.history.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HistoryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _notificationsNavigatorKey,
            routes: [
              GoRoute(
                path: '/notifications',
                name: AppRoute.notifications.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: NotificationsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.account.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: AccountScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
