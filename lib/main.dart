import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:flutter_application_1/config/providers/theme_provider.dart';
import 'package:flutter_application_1/config/router/router_config.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

// Myapp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, authProvider, themeProvider, child) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: themeProvider.globalTheme.themeSettings,
        routerConfig: getRouterConfig(authProvider),
      );
    });
  }
}
