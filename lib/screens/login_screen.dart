import 'package:flutter/material.dart';
import '../resources/auth_mehtod.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textField.dart';
import '../widgets/loading_indicator.dart';

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

  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethod.loginUser(
      context,
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });
    if (res) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : SingleChildScrollView(
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
                        text: 'Email',
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
                        text: 'Password',
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
