import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie/constants.dart';
import 'package:movie/modules/main/main_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var currentUserAccountId = ''.obs;

  Future<String> loginViaWebsite() async {
    try {
      final String requestToken = await createRequestToken();

      final String loginUrl =
          'https://www.themoviedb.org/authenticate/$requestToken';

      if (await launchUrl(Uri.parse(loginUrl))) {
        log('girdi');
        final result = await FlutterWebAuth.authenticate(
            url: loginUrl, callbackUrlScheme: 'foobar');
        log(result + ' AQ');
        var sessionId = await createSession(requestToken);
        return sessionId;
      } else {
        throw 'Could not launch $loginUrl';
      }
    } catch (error) {
      print('Login via website failed: $error');
      return 'failed';
    }
  }

  Future<String> createRequestToken() async {
    const String apiUrl =
        'https://api.themoviedb.org/3/authentication/token/new';
    String accessToken = dotenv.env['API_KEY']!;
    final response = await http.get(
      Uri.parse('$apiUrl?api_key=$accessToken'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['request_token'];
    } else {
      Get.snackbar('Error', 'Failed to Create Token');
      throw Exception('Failed to create request token');
    }
  }

  Future<String> getAccountId(String sessionId) async {
    const String apiUrl = 'https://api.themoviedb.org/3/account';
    String apiKey = dotenv.env['API_KEY']!;
    final response = await http.get(
      Uri.parse('$apiUrl?api_key=$apiKey&session_id=$sessionId'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['id'].toString();
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage =
          errorResponse['status_message'] ?? 'Unknown error occurred';
      throw Exception('Failed to get account ID: $errorMessage');
    }
  }

  Future<String> loginWithUsernameAndPassword(
      String username, String password, String requestToken) async {
    const String apiUrl =
        'https://api.themoviedb.org/3/authentication/token/validate_with_login';
    String apiKey = dotenv.env['SESSION_KEY']!;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'content-type': 'application/json'
      },
      body: json.encode({
        'username': username,
        'password': password,
        'request_token': requestToken
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['request_token'];
    } else {
      Get.snackbar(
        'Error',
        'Failed to login with username and password',
        colorText: Colors.white,
      );
      throw Exception('Failed to login with username and password');
    }
  }

  Future<String> createSession(String requestToken) async {
    log(requestToken);
    const String apiUrl =
        'https://api.themoviedb.org/3/authentication/session/new';
    String apiKey = dotenv.env['SESSION_KEY']!;
    final response = await http.post(
      Uri.parse('$apiUrl?api_key=$apiKey'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'content-type': 'application/json'
      },
      body: json.encode({'request_token': requestToken}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['session_id'];
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage =
          errorResponse['status_message'] ?? 'Unknown error occurred';
      throw Exception('Failed to create session: $errorMessage');
    }
  }

  Future<void> authenticateUser(String username, String password) async {
    try {
      final String requestToken = await createRequestToken();
      final String validatedRequestToken =
          await loginWithUsernameAndPassword(username, password, requestToken);
      final String sessionId = await createSession(validatedRequestToken);

      final String accountId = await getAccountId(sessionId);
      currentUserId = accountId;
      log(currentUserId + ' USER ID BU MU');
      log('Account ID: $accountId');

      Get.offAll(MainScreen());
    } catch (error) {
      print('Authentication failed: $error');
    }
  }
}
