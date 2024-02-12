import 'package:be_my_eyes/widgets/personal_info.dart';
import 'package:be_my_eyes/widgets/volunteer_globe.dart';
import 'package:flutter/material.dart';

class HomeVolunteer extends StatelessWidget {
  const HomeVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const VolunteerGlobe(),
          const SizedBox(
            height: 20,
          ),
          const PersonalInfo(),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              'You\'ll receive a notification when someone needs your help',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: const Color(0xFF004de9),
                foregroundColor: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Learn how to answer a call',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
