import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/modules/auth/components/login_button.dart';
import 'package:movie/modules/search/components/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'The Movie Manager',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Login with Email',
              style: TextStyle(color: Colors.white54, fontSize: 15),
            ),
          ),
          CustomFormField(
            hint: 'Email',
            obscureText: false,
            onChanged: (input) {},
            prefixIcon: Icons.person,
          ),
          CustomFormField(
            hint: 'Password',
            obscureText: true,
            onChanged: (input) {},
            prefixIcon: Icons.password,
          ),
          SizedBox(
            height: 10,
          ),
          LoginButton(text: 'Login', onTap: () {}),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style: TextStyle(color: Colors.white54, fontSize: 20),
            ),
          ),
          LoginButton(text: 'Login via Website', onTap: () {}),
        ],
      ),
    );
  }
}
