// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class APIChart {
  Future<List> fetchData(type) async {
    var token = LocalStorage.getToken();
    var serial = LocalStorage.getSerial();
    String url = "http://cloud.yobeen.com/api/getdatadevice";
    final response = await http.post(Uri.parse(url),
        body: {"token": "$token", "serial": "$serial", "slot": "$type"});

    if (response.statusCode == 200) {
      var datasvalue = jsonDecode(response.body);
      return datasvalue['datas'];
    } else {
      return [null];
    }
  }
}
