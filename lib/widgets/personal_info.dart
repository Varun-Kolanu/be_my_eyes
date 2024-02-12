import 'dart:convert';

import 'package:be_my_eyes/utils/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  Map<String, dynamic>? _profile;

  Future<void> fetchData() async {
    final backendUrl = dotenv.env['BACKEND_URL'];
    final jwt = await readFromPreferences('jwt');
    final response = await http.get(
      Uri.parse("$backendUrl/api/auth/main_screen_profile"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _profile = json.decode(response.body);
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10, // Blur radius
            offset: const Offset(0, 4), // Offset
          ),
        ],
      ),
      child: _profile == null
          ? const SizedBox(height: 0)
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(
                    _profile?['name'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'member since ${_profile?["joinDate"]}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      _profile?['language'],
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
