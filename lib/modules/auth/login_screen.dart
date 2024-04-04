import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/auth_controller.dart';
import 'package:movie/modules/auth/components/login_button.dart';
import 'package:movie/modules/main/main_screen.dart';
import 'package:movie/modules/search/components/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'The Movie Manager',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Login with Email',
              style: TextStyle(color: Colors.white54, fontSize: 15),
            ),
          ),
          CustomFormField(
            hint: 'Email',
            obscureText: false,
            onChanged: (input) {
              authController.username.value = input;
            },
            prefixIcon: Icons.person,
          ),
          CustomFormField(
            hint: 'Password',
            obscureText: true,
            onChanged: (input) {
              authController.password.value = input;
            },
            prefixIcon: Icons.password,
          ),
          SizedBox(
            height: 10,
          ),
          LoginButton(
              text: 'Login',
              onTap: () {
                authController.authenticateUser(authController.username.value,
                    authController.password.value);
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style: TextStyle(color: Colors.white54, fontSize: 20),
            ),
          ),
          LoginButton(
              text: 'Login via Website',
              onTap: () {
                authController.loginViaWebsite().then((sessionId) {
                  if (sessionId != 'asd' && sessionId.isNotEmpty) {
                    Get.offAll(MainScreen());
                  } else {}
                });
              }),
        ],
      ),
    );
  }
}
