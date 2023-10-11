import 'package:assessment_test/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String title;
  final bool isPrefix;
  final bool isTitle;
  final TextEditingController controller;
  const AppTextField({
    super.key,
    this.isPrefix = false,
    this.isTitle = true,
    required this.hintText,
    required this.controller,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF434343),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 0.12,
          ),
        ),
        SizedBox(height: 10),
            
        TextField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: hintText,
        
            hintStyle: TextStyle(
              color: Color(0xFF434343),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: mainColor,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
