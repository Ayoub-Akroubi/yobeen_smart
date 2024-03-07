// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/Dashboard/Model/lastDataModel.dart';
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class APILastData {
  var token = LocalStorage.getToken();
  var serial = LocalStorage.getSerial();
  Future<dynamic> fetchLastData() async {
    String url = "http://cloud.yobeen.com/api/getdatadevice";
    final response = await http.post(Uri.parse(url),
        body: {"token": "$token", "serial": "$serial", "slot": ""});

    if (response.statusCode == 200) {
      var datasvalue = jsonDecode(response.body);

      return datasvalue;
    } else {
      return [null];
    }
  }
}

List<LastDataModel> _lastData = [];
Map lastData = {};
List lastDataKeys = [];
List lastDataValues = [];

Future<List<LastDataModel>> getLastData() async {
  await APILastData().fetchLastData().then((data) => {
        if (data["lastdata"].isEmpty)
          {
            _lastData.clear(),
            _lastData = [],
          }
        else
          {
            _lastData.clear(),
            lastData = data["lastdata"],
            lastData.forEach((key, value) {
              for (var i = 0; i < data["sonsors"].length; i++) {
                if (key.toString() == data["sonsors"][i]["slug"].toString()) {
                  _lastData.add(LastDataModel(
                    sensors_name: data["sonsors"][i]["name"].toString(),
                    sensors_slug: data["sonsors"][i]["slug"].toString(),
                    sensors_unity: data["sonsors"][i]["unity"].toString(),
                    sensors_color: data["sonsors"][i]["color"].toString(),
                    sensors_icon: data["sonsors"][i]["icon"].toString(),
                    value: value.toString(),
                  ));
                }
              }
            }),
          },
      });

  return _lastData;
}
