import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:prsenentaion_firebase/UI/Auth/signup/sign_up.dart';
import 'package:prsenentaion_firebase/UI/homescreen/home.dart';
import 'package:prsenentaion_firebase/util/colors.dart';
import 'package:prsenentaion_firebase/util/flutter_toast.dart';
import 'package:prsenentaion_firebase/widget/CustomButton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool is_loading = false;
  loginFunction() {
    is_loading = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        fluttertoas()
            .showpopup(Pro_Color.main_light_color, 'Login successful!');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        is_loading = false;
        setState(() {});
      }).onError((error, stackTrace) {
        fluttertoas().showpopup(Colors.red, error.toString());
        is_loading = false;
        setState(() {});
      });
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pro_Color.backcolor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Welcome Section
            Row(
              children: [
                Container(
                  height: 250,
                  width: 360,
                  decoration: BoxDecoration(
                    color: Pro_Color.main_light_color,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(150),
                      bottomLeft: Radius.circular(150),
                    ),
                  ),
                  // child: ClipRRect(
                  //     child: Image.asset(
                  //   'asset/pink_layers.jpeg',
                  //   fit: BoxFit.cover,
                  // )),
                  child: Center(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wellcome\nBack',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Hey! Good to see you again',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Login Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email TextFormField
                      TextFormField(
                        controller: emailController,
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: Colors.white.withOpacity(.1),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Pro_Color.main_dark_color),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: emailValidator,
                      ),
                      const SizedBox(height: 20),

                      // Password TextFormField
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          filled: true,
                          fillColor: Colors.white.withOpacity(.1),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Pro_Color.main_dark_color),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 10),

                     
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password action
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Pro_Color.main_light_color,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Login Button
                      Custombutton(
                        is_loading: is_loading,
                        text: 'log in',
                        color: Pro_Color.main_light_color,
                        onTap: loginFunction,
                      ),
                      SizedBox(
                        height: 125,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t an account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()),
                              );
                            },
                            child: const Text(
                              'sign up',
                              style: TextStyle(
                                color: Pro_Color.main_light_color,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

















