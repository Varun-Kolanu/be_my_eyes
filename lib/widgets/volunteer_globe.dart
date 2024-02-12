import 'package:be_my_eyes/widgets/roles_mainscreen.dart';
import 'package:flutter/material.dart';

class VolunteerGlobe extends StatelessWidget {
  const VolunteerGlobe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0076fd),
            Color(0xFF0035dd),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Image.asset(
                'assets/images/globe.jpg',
                width: 150,
                height: 150,
              ),
            ),
          ),
          const RolesMain(),
        ],
      ),
    );
  }
}
