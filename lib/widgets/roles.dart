import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Roles extends StatefulWidget {
  const Roles({super.key});

  @override
  State<Roles> createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  Map<String, dynamic>? _roles;

  Future<void> fetchData() async {
    final backendUrl = dotenv.env['BACKEND_URL'];
    if (backendUrl != null) {
      final response =
          await http.get(Uri.parse("$backendUrl/api/utils/roles_count"));
      if (response.statusCode == 200) {
        setState(() {
          _roles = json.decode(response.body);
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    }
  }

  Widget _rolesColumn(int number, String text) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _roles == null
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _rolesColumn(_roles?['blind'], 'Blind'),
                _rolesColumn(_roles?['volunteer'], 'Volunteers'),
              ],
            ),
          );
  }
}
