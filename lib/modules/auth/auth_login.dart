import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/modules/main/main_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

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
        inspect(change);
        var sonuc = change.url!.split('/');
        if (sonuc[5] == 'allow') {
          Get.offAll(MainScreen());
        } else {}
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;

        //   if (request.url.startsWith('https://www.youtube.com/')) {
        //   return NavigationDecision.prevent;
        //}
        //return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(
      Uri.parse('https://www.themoviedb.org/authenticate/${Get.arguments[0]}'));
