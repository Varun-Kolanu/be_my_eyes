import 'package:be_my_eyes/screens/authentication.dart';
import 'package:be_my_eyes/screens/home_blind.dart';
import 'package:be_my_eyes/screens/settings.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:be_my_eyes/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _handleLogout(BuildContext context) async {
    await deleteFromPreferences('jwt');
    await deleteFromPreferences('role');
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => const AuthenticationScreen(),
        ),
        (Route route) => false,
      );
    }
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeBlind(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Be My Eyes',
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blue[800],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
