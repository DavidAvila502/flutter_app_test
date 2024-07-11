import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigators/drawer_navigator.dart';
import 'package:flutter_application_1/presentation/login_screen.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
    child: const MyApp(),
  ));
}

// Router settings

GoRouter getRouter(context) {
  final authProvider = Provider.of<AuthProvider>(context);

  return GoRouter(
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const LoginScreen(
                  title: 'Login Screen',
                )),
        GoRoute(
            path: '/drawer',
            builder: (context, state) => const DrawerNavigator())
      ],
      redirect: (context, state) {
        if (authProvider.isLoggedIn) {
          return '/drawer';
        } else {
          return '/';
        }
      });
}

// Myapp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: getRouter(context),
    );
  }
}
