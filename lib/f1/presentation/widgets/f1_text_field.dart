import 'package:flutter/material.dart';

class F1TextField extends StatelessWidget {
  const F1TextField({
    super.key,
    required this.controller,
    this.hint = '',
    this.minLines = 1,
    this.maxLines,
    this.validator,
    this.textInputAction, this.preIcon,

  });

  final TextEditingController controller;
  final String hint;
  final int minLines;
  final int? maxLines;
  final IconData? preIcon;
  final String? Function(String?)? validator;

  final TextInputAction? textInputAction;


  static const Color _card = Color(0xFF18191A);
  static const Color _f1Red = Color(0xFFE10600);

  OutlineInputBorder _border(Color color, {double opacity = .25}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color.withOpacity(opacity), width: 1.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: TextInputType.multiline,
      cursorColor: _f1Red,
      expands: false,
      minLines: minLines,
      maxLines: maxLines ?? null,

      style: const TextStyle(
        color: Colors.white,
        fontSize: 18, // Bigger font
        height: 1.6, // More space between lines
        fontFamily: 'TitilliumWeb',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(preIcon),
        filled: true,
        fillColor: _card,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white38,
          fontFamily: 'TitilliumWeb',
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),

        enabledBorder: _border(_f1Red, opacity: .18),
        focusedBorder: _border(_f1Red, opacity: .45),
        errorBorder: _border(Colors.redAccent, opacity: .9),
        focusedErrorBorder: _border(Colors.redAccent, opacity: 1),
      ),
    );
  }
}
