import 'package:flutter/material.dart';

class HomeBlind extends StatelessWidget {
  const HomeBlind({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // Set border radius as needed
                ),
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(
                    double.infinity, 300), // Set width and height as needed
              ),
              backgroundColor: const MaterialStatePropertyAll(
                Color(0xFF085fef),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Call first available volunteer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(4), // Set border radius as needed
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(
                    color: Colors.grey[300]!, // Set border color here
                    width: 1.0, // Set border width here
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(
                      double.infinity, 100), // Set width and height as needed
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  Colors.white,
                )),
            child: Text(
              'My groups',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
          )
        ],
      ),
    );
  }
}
