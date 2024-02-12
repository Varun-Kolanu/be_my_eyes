import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RolesMain extends StatefulWidget {
  const RolesMain({super.key});

  @override
  State<RolesMain> createState() => _RolesMainState();
}

class _RolesMainState extends State<RolesMain> {
  Map<String, dynamic>? _rolesMain;

  Future<void> fetchData() async {
    final backendUrl = dotenv.env['BACKEND_URL'];
    if (backendUrl != null) {
      final response =
          await http.get(Uri.parse("$backendUrl/api/utils/roles_count"));
      if (response.statusCode == 200) {
        setState(() {
          _rolesMain = json.decode(response.body);
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    }
  }

  Widget _rolesMainColumn(int number, String text) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white60,
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
    return _rolesMain == null
        ? const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _rolesMainColumn(_rolesMain?['blind'], 'Blind'),
                _rolesMainColumn(_rolesMain?['volunteer'], 'Volunteers'),
              ],
            ),
          );
  }
}
