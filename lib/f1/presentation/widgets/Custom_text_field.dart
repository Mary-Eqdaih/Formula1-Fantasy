import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.label,
    this.preIcon, this.suffixIcon,
  });
  final String? label;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Icon? preIcon;
  final IconButton? suffixIcon;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon:preIcon,
        labelText: label,
        errorStyle: TextStyle(color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xffACACAC)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white70),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
