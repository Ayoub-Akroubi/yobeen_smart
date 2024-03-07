import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/Map/Model/model_station_map.dart';
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class APIStationsMap {
  Future<List> getStations() async {
    var token = LocalStorage.getToken();
    String url = 'http://cloud.yobeen.com/api/getdevicesmobile';
    final response = await http.post(Uri.parse(url), body: {'token': token});

    if (response.statusCode == 200) {
      return json
          .decode(response.body)["devices"]
          .map((e) => StationMapModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
