import 'package:flutter/material.dart';
import 'package:live_stream_app/resources/auth_mehtod.dart';
import 'package:live_stream_app/screens/home_screen.dart';
import 'package:live_stream_app/widgets/custom_button.dart';
import 'package:live_stream_app/widgets/custom_textField.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/singup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final size = MediaQuery.of(context).size;

    final AuthMethod _authMethod = AuthMethod();

    void signUpUser() async {
      bool res = await _authMethod.signUpUser(
        context,
        _emailController.text,
        _usernameController.text,
        _passwordController.text,
      );

      if (res) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: CustomTextField(
                  controller: _emailController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Username',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: CustomTextField(
                  controller: _usernameController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: CustomTextField(
                  controller: _passwordController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(function: signUpUser, text: 'Sign Up'),
            ],
          ),
        ),
      ),
    );
  }
}
