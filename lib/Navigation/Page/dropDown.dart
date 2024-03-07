// ignore_for_file: await_only_futures, file_names

import 'package:flutter/material.dart';
import 'package:yobeen_smart/Navigation/API/api_stations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class MyDrop extends StatefulWidget {
  const MyDrop({Key? key}) : super(key: key);

  @override
  State<MyDrop> createState() => _MyDropState();
}

class _MyDropState extends State<MyDrop> {
  bool _visibility = false;
  final List _stationList = [];
  final List _stationSerial = [];
  final List _stationName = [];
  dynamic _first = "";
  late APIStations apiStations;
  dynamic serial;

  initStateAsync() async {
    apiStations = await APIStations();
    apiStations.getStations().then((value) {
      setState(() {
        _visibility = true;
        for (var i = 0; i < value.length; i++) {
          if (value[i]["name_fr"] == null) {
            _stationSerial.add(value[i]["serial"].toString());
            _stationName.add(' ');
          } else {
            _stationSerial.add(value[i]["serial"].toString());
            _stationName.add(value[i]["name_fr"].toString());
          }
          _stationList.add(_stationSerial[i] + ' - ' + _stationName[i]);
          _first = _stationSerial[0] + " - " + _stationName[0];
        }
      });
    });
  }

  @override
  void initState() {
    initStateAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange, width: 2),
              color: Colors.amber[100]),
          child: Visibility(
            visible: _visibility,
            child: DropdownSearch<String>(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              dropdownSearchDecoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, top: 10),
                border: InputBorder.none,
              ),
              mode: Mode.MENU,
              showSearchBox: true,
              showSelectedItem: true,
              items: _stationList.map((e) => e.toString()).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  _first = '$newValue';
                  for (var i = 0; i < _stationList.length; i++) {
                    if (newValue == _stationList[i]) {
                      LocalStorage.deleteSerial();
                      LocalStorage.saveSerial(_stationSerial[i].toString());
                    }
                  }
                });
              },
              selectedItem: _first,
            ),
          ),
        ),
      ],
    );
  }
}
