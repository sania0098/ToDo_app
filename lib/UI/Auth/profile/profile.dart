import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/UI/Auth/login/login.dart';
import 'package:prsenentaion_firebase/UI/Auth/signup/sign_up.dart';
import 'package:prsenentaion_firebase/util/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  // final db = FirebaseDatabase.instance.ref('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Pro_Color.main_light_color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //profile pic
            Center(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade400),
                    child: Icon(
                      Icons.person,
                      size: 60,
                    ),
                  ),
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    currentUser.uid,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            //user email

            SizedBox(
              height: 70,
            ),

            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pro_Color.main_light_color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((v) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      });
                    },
                    icon: Icon(Icons.logout, color: Pro_Color.backcolor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(fontSize: 15, color: Pro_Color.backcolor),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pro_Color.main_light_color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.currentUser!.delete().then((v) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()));
                      });
                    },
                    icon: const Icon(Icons.delete, color: Pro_Color.backcolor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Delete account',
                    style: TextStyle(fontSize: 15, color: Pro_Color.backcolor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
