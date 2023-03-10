import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './provider/user_provider.dart';
import './resources/auth_mehtod.dart';
import './screens/home_screen.dart';
import './widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import './utils/colors.dart';

import './screens/onboarding_screen.dart';
import './screens/signup_screen.dart';
import './models/user.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBn5R8ptHmlnbsaWm5-b7-m4NVKmTMQs8s",
          authDomain: "twitch-clone-8daac.firebaseapp.com",
          projectId: "twitch-clone-8daac",
          storageBucket: "twitch-clone-8daac.appspot.com",
          messagingSenderId: "938664047507",
          appId: "1:938664047507:web:39c1eee530a8e380032e66"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitch clone',
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme.of(context).copyWith(
                backgroundColor: backgroundColor,
                elevation: 0,
                titleTextStyle: const TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            iconTheme: const IconThemeData(color: primaryColor)),
        routes: {
          OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          SignupScreen.routeName: (ctx) => const SignupScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
        home: FutureBuilder(
          future: AuthMethod()
              .getCurrentUser(
            FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null,
          )
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false).setUser(
                model.User.fromMap(value),
              );
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const OnboardingScreen();
          },
        ));
  }
}
