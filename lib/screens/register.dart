import 'dart:convert';

import 'package:be_my_eyes/screens/asking_role.dart';
import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:be_my_eyes/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleRegister(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String? backendUrl = dotenv.env['BACKEND_URL'];

    final response = await http.post(
      Uri.parse('$backendUrl/api/auth/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    String jwt = responseJson['jwt'];
    await saveToPreferences('jwt', jwt);
    String role = responseJson['role'];
    await saveToPreferences('role', role);
    print(response.body);
    if (context.mounted && response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AskingRoleScreen()),
      );
    }
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Register",
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                      ),
                    ),
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
                        onPressed: () => _handleRegister(context),
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
                          'Register',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
