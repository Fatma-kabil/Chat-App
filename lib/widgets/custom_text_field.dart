import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.hintText,
      this.icon,
      this.onchanged,
      this.obscureText = false});
  String? hintText;
  Icon? icon;
  bool obscureText = false;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: Colors.white70,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is reqired';
        }
        return null;
      },
      onChanged: onchanged,
      decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: Colors.white54,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.white60, fontFamily: ' Playwrite Cuba'),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          )),
    );
  }
}
