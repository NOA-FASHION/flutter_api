import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../../model/login/login_request_model.dart';
import '../../model/login/login_response_model.dart';
import '../../model/login/register_request_model.dart';
import '../../model/login/register_response_model.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String loginUrl = 'https://backend-strapi.online/api-flutter/api/login';
  final String registerUrl =
      'https://backend-strapi.online/api-flutter/api/register';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response =
        await post(loginUrl, model.toJson(), contentType: "application/json");

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model) async {
    final response = await post(registerUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return RegisterResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
