import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FirebaseHelper {
  late final String _apiKey;
  late final String _projectId;
  late final String _email;
  late final String _password;
  String _authToken = '';

  static final FirebaseHelper instance = FirebaseHelper._privateConstructor();
  FirebaseHelper._privateConstructor();

  Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    _apiKey = dotenv.get('APIKEY');
    _projectId = dotenv.get('PROJECTID');
    _email = dotenv.get('EMAIL');
    _password = dotenv.get('PASSWORD');
  }

  String get authToken => _authToken;
  String get projectId => _projectId;

  Future<void> authenticate() async {
    try {
      final urlAuth = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey');

      final Map<String, dynamic> authData = {
        'email': _email,
        'password': _password,
        'returnSecureToken': true,
      };

      final authResponse =
          await http.post(urlAuth, body: json.encode(authData));

      if (authResponse.statusCode == 200) {
        final authDataMap = json.decode(authResponse.body);
        _authToken = authDataMap['idToken'];
      } else {
        print('Authentication failed: ${authResponse.reasonPhrase}');
        _authToken = '';
      }
    } catch (error) {
      print('Error: $error');
      _authToken = '';
    }
  }
}
