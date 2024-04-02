import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/constants.dart';

class CustomFormField extends StatelessWidget {
  late final bool obscureText;

  late final String hint;
  void Function(String) onChanged;

  CustomFormField({
    required this.hint,
    required this.obscureText,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: key,
        child: TextFormField(
          cursorColor: kButtonColor,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          scrollPadding: EdgeInsets.only(bottom: 40),
          onChanged: onChanged,
          obscureText: obscureText,
          autofocus: false,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: 'VarelaRound',
          ),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.red),
            prefixIcon: Icon(
              Icons.search_rounded,
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
            hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }
}
