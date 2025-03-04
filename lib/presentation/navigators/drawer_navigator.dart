import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/presentation/screens/settings_screen.dart';
import 'package:flutter_application_1/config/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class DrawerNavigator extends StatefulWidget {
  const DrawerNavigator({super.key});

  @override
  State<DrawerNavigator> createState() => _DrawerNavigator();
}

class _DrawerNavigator extends State<DrawerNavigator> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = [HomeScreen(), SettingsScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'PokeApp',
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            leading: Builder(
              builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu));
              },
            ),
          ),
          body: SafeArea(child: _screens[_selectedIndex]),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text(value.userObj?.displayName ?? 'User'),
                    accountEmail: Text(value.userObj?.email ?? '@user'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: value.userObj?.photoUrl != null
                          ? NetworkImage(value.userObj!.photoUrl!)
                          : null,
                    )),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  selected: _selectedIndex == 0,
                  onTap: () {
                    _onItemTapped(0);
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    _onItemTapped(1);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
