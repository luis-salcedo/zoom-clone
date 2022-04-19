import 'package:flutter/material.dart';
import 'package:zoom/controllers/auth_controller.dart';
import 'package:zoom/screens/widgets/custom_button.dart';

import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  final _authController = AuthController().signInWithGoogle();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Start or join a meeting',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/onboarding.jpeg'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: CustomButton(
              text: 'Login',
              onPressed: () {
                //Authenticate User
                _authController;

                //Push User to Home Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
