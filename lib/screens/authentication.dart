import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Be My Eyes',
        ),
      ),
      body: Column(
        children: [
          const Text(
            'Join the community, See the world together',
          ),
          SizedBox(
            child: Image.asset(
              'assets/images/eyes.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
