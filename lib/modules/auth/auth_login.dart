import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/auth_controller.dart';
import 'package:movie/db_helper.dart';
import 'package:movie/modules/main/main_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

final AuthController authController = Get.put(AuthController());

class AuthLogin extends StatelessWidget {
  AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}

final controller = WebViewController()
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {},
      onUrlChange: (change) {
        getUserData(change.url!);
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(
      Uri.parse('https://www.themoviedb.org/authenticate/${Get.arguments[0]}'));

getUserData(String url) async {
  var sonuc = url.split('/');
  if (sonuc[5] == 'allow') {
    var session = await authController.createSession(
      Get.arguments[0],
    );
    inspect(session);

    var accountId = await authController.getAccountId(session);
    currentUserId = accountId;
    prefs.setString('currentUserId', currentUserId);

    Get.offAll(MainScreen());
  } else {}
}
