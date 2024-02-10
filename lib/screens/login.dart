import 'dart:convert';

import 'package:be_my_eyes/screens/asking_role.dart';
import 'package:be_my_eyes/screens/main_screen.dart';
import 'package:be_my_eyes/screens/register.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:be_my_eyes/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String? backendUrl = dotenv.env['BACKEND_URL'];

    final response = await http.post(
      Uri.parse('$backendUrl/api/auth/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    String jwt = responseJson['jwt'];
    await saveToPreferences('jwt', jwt);
    String role = responseJson['role'];
    await saveToPreferences('role', role);
    print(response.body);
    _emailController.clear();
    _passwordController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Login",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleLogin(context),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.blue[800],
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
