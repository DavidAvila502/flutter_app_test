import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, child) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings screens'),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                value.logout();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      );
    });
  }
}
