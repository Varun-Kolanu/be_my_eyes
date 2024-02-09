import 'package:be_my_eyes/widgets/auth_footer.dart';
import 'package:be_my_eyes/widgets/roles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final _appBar = AppBar(
    title: const Text(
      'Be My Eyes',
    ),
    backgroundColor: const Color(0xFF085fef),
    foregroundColor: Colors.white,
  );

  Widget _heading() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Text(
        'Join the community, See the world together',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _eyeImage() {
    return SizedBox(
      width: 400,
      height: 230,
      child: Image.asset(
        'assets/images/eyes.png',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(dotenv.env['BACKEND_URL']);
    return Scaffold(
      appBar: _appBar,
      body: SizedBox(
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _heading(),
                  _eyeImage(),
                  const Roles(),
                ],
              ),
              const AuthFooter(),
            ]),
      ),
    );
  }
}
