import 'package:be_my_eyes/screens/authentication.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Main Screen',
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => _handleLogout(context),
            child: const Text(
              'Logout',
            )),
      ),
    );
  }
}
