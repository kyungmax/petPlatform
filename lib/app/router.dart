import 'package:go_router/go_router.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/list/list_screen.dart';
import '../features/detail/detail_screen.dart';
import '../features/settings/settings_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
      GoRoute(path: '/list', builder: (c, s) => const ListScreen()),
      GoRoute(path: '/detail', builder: (c, s) => const DetailScreen()),
      GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
    ],
  );
}