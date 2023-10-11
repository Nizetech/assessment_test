import 'package:assessment_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String title;
  final bool isPrefix;
  final bool isTitle;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const AppTextField({
    super.key,
    this.validator,
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
          style: const TextStyle(
            color: Color(0xFF434343),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 0.12,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red),
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

class Bubble extends StatelessWidget {
  final Map data;
  const Bubble({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          data['isSender'] ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (data['isSender'])
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/check icon.png',
                  height: 20,
                  width: 20,
                ),
                SizedBox(height: 4),
                Text(
                  '14:24',
                  style: TextStyle(
                    color: Color(0xFF7D7F88),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          if (data['isSender']) SizedBox(width: 8),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: data['isSender']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                  minWidth: 100,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(data['isSender'] ? 10 : 0),
                    bottomRight: Radius.circular(data['isSender'] ? 0 : 10),
                  ),
                  color: data['isSender'] ? mainColor : Color(0xFFF4F4F4),
                ),
                child: Text(
                  data['text'],
                  style: TextStyle(
                    color: data['isSender'] ? Colors.white : Color(0xFF434343),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          if (!data['isSender'])
            Text(
              '14:24',
              style: TextStyle(
                color: Color(0xFF7D7F88),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
