import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class APITableau {
  var token = LocalStorage.getToken();
  var serial = LocalStorage.getSerial();
  Future<dynamic> fetchData() async {
    String url = "http://cloud.yobeen.com/api/getdatadevice";
    final response = await http.post(Uri.parse(url),
        body: {"token": "$token", "serial": "$serial", "slot": "brute"});
    if (response.statusCode == 200) {
      var datasvalue = jsonDecode(response.body);
      return datasvalue["datas"];
    } else {
      return [null];
    }
  }
}
