import 'package:flutter/material.dart';
import 'package:prsenentaion_firebase/util/colors.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.is_loading = false,
  });

  final String text; // Use explicit types for clarity
  final Color color;
  final VoidCallback onTap;
  final bool is_loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Center(
          // Ensures child is centered
          child: is_loading
              ? SizedBox(
                  width: 30, // Adjusted for better visibility
                  height: 30, // Adjusted for better visibility
                  child: CircularProgressIndicator(
                    color: Pro_Color.backcolor,
                    strokeWidth: 4.0,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
