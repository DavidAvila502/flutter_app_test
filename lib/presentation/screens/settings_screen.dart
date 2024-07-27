import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:flutter_application_1/config/providers/theme_provider.dart';
import 'package:flutter_application_1/config/themes/theme_config.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, authProvider, themeProvider, child) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings screens'),
            const SizedBox(
              height: 50,
            ),
            DropdownButton(
              value: themeProvider.globalTheme,
              items: [
                DropdownMenuItem(
                  value: pokeBallTheme,
                  child: const Text('Pokeball Theme'),
                ),
                DropdownMenuItem(
                    value: blueTheme, child: const Text('Blue Theme')),
                DropdownMenuItem(
                    value: purpleTheme, child: const Text('Purple Theme')),
                DropdownMenuItem(
                    value: goldenTheme, child: const Text('Golden Theme')),
              ],
              onChanged: (ThemeData? theme) {
                if (theme != null) {
                  themeProvider.setTheme(theme);
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.logout();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      );
    });
  }
}
