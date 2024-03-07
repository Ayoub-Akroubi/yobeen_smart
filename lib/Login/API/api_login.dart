import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Model/model_login.dart';

class APILogin {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://cloud.yobeen.com/api/authentification";
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
