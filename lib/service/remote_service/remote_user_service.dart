import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../controller/login/authentication_controler.dart';
import 'const.dart';

class RemoteUserService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/users';

  Future<dynamic> get(String token) async {
    var response = await client.get(
      Uri.parse(remoteUrl),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
    );
    return response;
  }

  Future<dynamic> signUp({required String token,
    required String email,
    required String password,
  }) async {
    var body = {"email": email, "plainPassword": password};
    var response = await client.post(
      Uri.parse('$baseUrl/api/users'),
     headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    return response;
  }
}
