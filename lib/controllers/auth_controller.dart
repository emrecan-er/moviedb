import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie/modules/main/main_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  Future<String> loginViaWebsite() async {
    try {
      final String requestToken = await createRequestToken();
      final String loginUrl =
          'https://www.themoviedb.org/authenticate/$requestToken';

      if (await canLaunch(loginUrl)) {
        await launch(loginUrl);
        log(requestToken);
        var sessionId = await createSession(requestToken);
        return sessionId;
      } else {
        throw 'Could not launch $loginUrl';
      }
    } catch (error) {
      print('Login via website failed: $error');
      return 'asds';
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

  Future<String> loginWithUsernameAndPassword(
      String username, String password, String requestToken) async {
    const String apiUrl =
        'https://api.themoviedb.org/3/authentication/token/validate_with_login';
    String apiKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGU4MGNkODMyNjUyYWQ0Yjg2NGM1MWM4ZTU4OGFlYyIsInN1YiI6IjY2MGM3OGQ0ZTAzOWYxMDE0OWU0NzExZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FwXC9wXvJJrOc8_j56Bl-h1fqtk8DjQIbDFxfjy_WwQ';
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
      log(sessionId);
      Get.offAll(MainScreen());
    } catch (error) {
      print('Authentication failed: $error');
    }
  }
}
