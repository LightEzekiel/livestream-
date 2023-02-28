import 'package:flutter/material.dart';
import 'package:live_stream_app/resources/auth_mehtod.dart';
import 'package:live_stream_app/screens/home_screen.dart';
import 'package:live_stream_app/widgets/custom_button.dart';
import 'package:live_stream_app/widgets/custom_textField.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethod _authMethod = AuthMethod();

  loginUser() async {
    bool res = await _authMethod.loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );
    if (res) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              CustomButton(function: loginUser, text: 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
