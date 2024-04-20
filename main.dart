import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBfplMWtISPRx12l5Qy56UFs3bc8ZIAmww',
      // paste your api key here
      appId: '1:722912789091:android:b3e5c234328bf599716e56',
      //paste your app id here
      messagingSenderId: '722912789091',
      //paste your messagingSenderId here
      projectId: 'sample-authorization-b1f23', //paste your project id here
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Project',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to the next screen
    Future.delayed(
      Duration(seconds: 2), // Adjust the duration as needed
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        width:300, // Set width to fill the screen
        height: 300, // Set height to fill the screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/recruit.jpg'),
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
      ),
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.slideTransition,
      duration: 200000, // Adjust the duration of the splash screen animation
    );
  }
}