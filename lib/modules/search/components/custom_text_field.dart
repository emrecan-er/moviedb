import 'package:flutter/material.dart';
import 'package:movie/constants.dart';

class CustomFormField extends StatelessWidget {
  late final bool obscureText;
  late final IconData prefixIcon;
  late final String hint;
  void Function(String) onChanged;

  CustomFormField({
    required this.hint,
    required this.obscureText,
    required this.onChanged,
    required this.prefixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: key,
        child: TextFormField(
          cursorColor: kButtonColor,
          keyboardType: TextInputType.multiline,
          maxLines: 1,
          scrollPadding: const EdgeInsets.only(bottom: 40),
          onChanged: onChanged,
          obscureText: obscureText,
          autofocus: false,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: 'VarelaRound',
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.red),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white,
            ),
            filled: true,
            fillColor: kFormFieldColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }
}
