import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class APIStations {
  Future<List> getStations() async {
    var token = LocalStorage.getToken().toString();
    String url = 'http://cloud.yobeen.com/api/getdevicesmobile';

    final response = await http.post(Uri.parse(url), body: {'token': token});
    var stations = jsonDecode(response.body);

    return stations['devices'];
  }
}
