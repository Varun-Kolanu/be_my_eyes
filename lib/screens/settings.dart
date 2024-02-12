import 'package:be_my_eyes/screens/authentication.dart';
import 'package:flutter/material.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Settings extends StatelessWidget {
  const Settings({super.key});

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

  void _handleDelete(BuildContext context) async {
    final backendUrl = dotenv.env['BACKEND_URL'];
    final jwt = await readFromPreferences('jwt');
    final response = await http.delete(
      Uri.parse(
        '$backendUrl/api/auth/',
      ),
      headers: {
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.statusCode == 200) {
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _handleLogout(context),
            child: const Text(
              'Logout',
            ),
          ),
          ElevatedButton(
            onPressed: () => _handleDelete(context),
            child: const Text(
              'Delete Account',
            ),
          ),
        ],
      ),
    );
  }
}
