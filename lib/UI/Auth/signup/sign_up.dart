import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/UI/Auth/login/login.dart';
import 'package:prsenentaion_firebase/UI/homescreen/home.dart';
import 'package:prsenentaion_firebase/util/colors.dart';
import 'package:prsenentaion_firebase/util/flutter_toast.dart';
import 'package:prsenentaion_firebase/widget/CustomButton.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool isAgreed = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool is_loading = false;

  signup_function() {
    if (_formKey.currentState!.validate()) {
      is_loading = true;
      setState(() {});
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((v) {
        fluttertoas().showpopup(Colors.blue, 'Sign up successfully!');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        is_loading = false;
        setState(() {});
      }).onError((error, stackTrace) {
        fluttertoas().showpopup(Colors.red, error.toString());
      });
    } else {
      fluttertoas().showpopup(
          Colors.red, 'Please fill in all fields correctly and agree to terms');
      is_loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pro_Color.backcolor,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Hello! lets join with us',
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

              const SizedBox(height: 40),

              // Signup Form
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: usernameController,
                          autofocus: true,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'USER NAME',
                            hintText: 'Username',
                            filled: true,
                            fillColor: Colors.white.withOpacity(.3),
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 6.0,
                              top: 8.0,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: emailController,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'EMAIL ADDRESS',
                            hintText: 'Enter email address',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 6.0,
                              top: 8.0,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            hintText: 'Enter password',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 6.0,
                              top: 8.0,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  isAgreed = value ?? false;
                                });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'I accept the policy and terms',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Signup Button

                      Custombutton(
                          is_loading: is_loading,
                          text: 'sign up',
                          color: Pro_Color.main_light_color,
                          onTap: signup_function),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                color: Pro_Color.main_dark_color,
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
            ],
          ),
        ),
      ),
    );
  }
}
