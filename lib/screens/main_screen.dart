import 'package:be_my_eyes/screens/home_blind.dart';
import 'package:be_my_eyes/screens/home_volunteer.dart';
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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CustomScreen(),
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

class CustomScreen extends StatelessWidget {
  const CustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: readFromPreferences('role'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final role = snapshot.data;
          if (role == 'blind') {
            return const HomeBlind();
          }
          return const HomeVolunteer();
        }
      },
    );
  }
}
