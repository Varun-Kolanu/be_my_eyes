import 'package:be_my_eyes/screens/asking_role.dart';
import 'package:be_my_eyes/screens/authentication.dart';
import 'package:be_my_eyes/screens/main_screen.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: readFromPreferences('jwt'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final jwt = snapshot.data;
          if (jwt == null) {
            return const AuthenticationScreen();
          }
          return const MainScreen();
        }
      },
    );
  }
}
