import 'package:flutter/material.dart';
import 'package:live_stream_app/screens/signup_screen.dart';
import '../screens/login_screen.dart';
import '../widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to \nLiveStream',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                  function: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  text: 'Log in'),
            ),
            CustomButton(
                function: () {
                  Navigator.of(context).pushNamed(SignupScreen.routeName);
                },
                text: 'Sign up'),
          ],
        ),
      ),
    );
  }
}
