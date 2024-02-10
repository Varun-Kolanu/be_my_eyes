import 'dart:convert';

import 'package:be_my_eyes/screens/asking_role.dart';
import 'package:be_my_eyes/screens/login.dart';
import 'package:be_my_eyes/screens/main_screen.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthFooter extends StatefulWidget {
  const AuthFooter({super.key});

  @override
  State<AuthFooter> createState() => _AuthFooterState();
}

class _AuthFooterState extends State<AuthFooter> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void _handleGoogleSignin(BuildContext context) async {
    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      print('Error disconnecting from Google Sign-In: $e');
      // Handle the error appropriately, such as showing a message to the user
    }
    try {
      final result = await _googleSignIn.signIn();
      if (result != null) {
        final googleKey = await result.authentication;
        String? token = googleKey.accessToken;
        String? backendUrl = dotenv.env['BACKEND_URL'];
        final response = await http.post(
          Uri.parse('$backendUrl/api/auth/google'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'access_token': token}),
        );
        Map<String, dynamic> responseJson = json.decode(response.body);
        String jwt = responseJson['jwt'];
        await saveToPreferences('jwt', jwt);
        String role = responseJson['role'];
        await saveToPreferences('role', role);
        if (context.mounted) {
          if (role == 'new') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AskingRoleScreen()),
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => const MainScreen(),
              ),
              (Route route) => false,
            );
          }
        }
        print(response.body);
      } else {
        print('Sign-in result is null');
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: SignInButton(
                Buttons.google,
                onPressed: () => _handleGoogleSignin(context),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.blue[800],
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 50))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Sign in with email',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
