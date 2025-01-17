import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/util/colors.dart';

class textfield_widget extends StatelessWidget {
  const textfield_widget(
      {super.key,
      required this.Controller,
      required this.hinttext,
      required this.labeltext});

  final TextEditingController Controller;
  final labeltext;
  final hinttext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Controller,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        filled: true,
        fillColor: Colors.white.withOpacity(.1),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 14.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Pro_Color.main_dark_color),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
   
   
   
   
   
   
    );
  }
}
