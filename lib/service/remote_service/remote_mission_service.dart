import 'dart:convert';

import 'package:http/http.dart' as http;

import 'const.dart';

class RemoteMissionService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/missions';

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

  Future<dynamic> adMission(
      {required String token,
        required String name,
      required String description,
      required int idUser}) async {
    var body = {
      "name": name,
      "description": description,
      "user": "/api-flutter/api/users/$idUser"
    };
    var response = await client.post(
      Uri.parse('$baseUrl/api/missions'),
        headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    return response;
  }
}
