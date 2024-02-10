import 'dart:convert';

import 'package:be_my_eyes/screens/main_screen.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:be_my_eyes/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AskingRoleScreen extends StatelessWidget {
  const AskingRoleScreen({super.key});

  void _handleRoleUpdate(String role, BuildContext context) async {
    String? backendUrl = dotenv.env['BACKEND_URL'];
    String? jwt = await readFromPreferences('jwt');
    if (jwt != null) {
      final response = await http.patch(
        Uri.parse('$backendUrl/api/auth/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode({'role': role}),
      );
      Map<String, dynamic> responseJson = json.decode(response.body);
      String newRole = responseJson['role'];
      await saveToPreferences('role', newRole);
      print(response.body);
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const MainScreen(),
            ),
            (Route route) => false,
          );
        }
      }
    }
    // print(jwt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Be My Eyes",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _handleRoleUpdate('blind', context),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue[700]),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                child: const Text(
                  'I need visual assistance',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => _handleRoleUpdate('volunteer', context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue[700]),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  child: const Text(
                    'I\'d like to volunteer',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
