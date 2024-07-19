import 'package:flutter_application_1/presentation/navigators/drawer_navigator.dart';
import 'package:flutter_application_1/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/presentation/screens/splash_screen.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// Router settings

GoRouter getRouterConfig(context) {
  final authProvider = Provider.of<AuthProvider>(context);

  return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
        GoRoute(
            path: '/login',
            builder: (context, state) =>
                const LoginScreen(title: 'Login Screen')),
        GoRoute(
            path: '/drawer',
            builder: (context, state) => const DrawerNavigator())
      ],
      redirect: (context, state) {
        if (authProvider.isLoading == true) {
          return '/';
        }

        if (authProvider.isLoggedIn) {
          return '/drawer';
        } else {
          return '/login';
        }
      });
}
