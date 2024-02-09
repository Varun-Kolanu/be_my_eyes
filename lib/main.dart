import 'dart:convert';

import 'package:be_my_eyes/screens/authentication.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void _handleSignIn() async {
    try {
      final result = await _googleSignIn.signIn();
      if (result != null) {
        final googleKey = await result.authentication;
        String? token = googleKey.accessToken;
        String backendUrl = 'http://172.20.3.85:5000';
        final response = await http.post(
          Uri.parse('$backendUrl/api/auth/google'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'access_token': token}),
        );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Be My Eyes'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: const Text('Signin with Google'),
        ),
      ),
    );
  }
}
