// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class APISonsors {
  Future<dynamic> fetchSonsors() async {
    var token = LocalStorage.getToken();
    var serial = LocalStorage.getSerial();
    String url = "http://cloud.yobeen.com/api/getdatadevice";
    final response = await http.post(Uri.parse(url),
        body: {"token": "$token", "serial": "$serial", "slot": "brute"});

    var datasvalue = jsonDecode(response.body);
    return datasvalue["sonsors"];
  }
}

List _sonsors = [];
Future<List> getSonsors() async {
  _sonsors.clear();
  await APISonsors().fetchSonsors().then((value) => {_sonsors.add(value)});

  return _sonsors;
}
