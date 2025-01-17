import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:prsenentaion_firebase/UI/Auth/signup/sign_up.dart';
import 'package:prsenentaion_firebase/UI/homescreen/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), move_function);
  }

  void move_function() {
    final user = FirebaseAuth.instance.currentUser;
    print('this is user $user');

    // Check if the user is authenticated
    if (user == null) {
      // If no user is logged in, navigate to Signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signup()),
      );
    } else {
      // If user is logged in, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/pink_layers.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
