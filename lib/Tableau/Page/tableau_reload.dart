import 'package:flutter/material.dart';
import 'package:yobeen_smart/Dashboard/API/api_sonsors.dart';
import 'package:yobeen_smart/Tableau/API/api_tableau.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';

class TableauRelaod extends StatefulWidget {
  const TableauRelaod({Key? key}) : super(key: key);

  @override
  State<TableauRelaod> createState() => _TableauRelaodState();
}

class _TableauRelaodState extends State<TableauRelaod> {
  late APITableau apiTableau = APITableau();

  APISonsors apiLastData = new APISonsors();
  List dataList = [];
  List sonsorsNames = [];
  bool visible = true;
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  Future<List> fetchResults() async {
    var token = LocalStorage.getToken();
    var serial = LocalStorage.getSerial();
    Uri url = Uri.parse("http://cloud.yobeen.com/api/getdatadevice");

    final response = await http.post(url,
        body: {"token": "$token", "serial": "$serial", "slot": "brute"});
    var resultsJson = json.decode(response.body)["sonsors"];
    resultsJson.map((e) => sonsorsNames.add(e["slug"]));
    await Future.delayed(const Duration(seconds: 2), () {});
    return sonsorsNames;
  }

  void initStateAsync() async {
    await apiLastData.fetchSonsors().then((value) => {
          setState(() {
            for (var i = 0; i < value.length; i++) {
              sonsorsNames.add(value[i]["slug"]);
            }
          }),
        });

    await apiTableau.fetchData().then((value) => {
          if (value.isEmpty)
            {
              if (mounted)
                {
                  setState(() {
                    visible = false;
                  })
                }
            }
          else
            {
              if (mounted)
                {
                  setState(() {
                    visible = true;
                    dataList = value;
                  }),
                },
            },
        });
  }

  @override
  void initState() {
    initStateAsync();
    super.initState();
  }

  List<DataColumn> _createColumns() {
    return List.generate(sonsorsNames.length, (index) {
      if (index == 0) {
        return DataColumn(
          label: Text(sonsorsNames[index]),
          onSort: (columnIndex, _) {
            setState(() {
              _currentSortColumn = columnIndex;
              if (_isSortAsc) {
                dataList.sort((a, b) => b['datetime'].compareTo(a['datetime']));
              } else {
                dataList.sort((a, b) => a['datetime'].compareTo(b['datetime']));
              }
              _isSortAsc = !_isSortAsc;
            });
          },
        );
      } else {
        return DataColumn(label: Text(sonsorsNames[index]));
      }
    });
  }

  SingleChildScrollView _createDataTable() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
            future: fetchResults(),
            builder: (context, snapshot) {
              if (snapshot.hasError ||
                  snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: MediaQuery.of(context).size.height - 100 / 100,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child:
                        const CircularProgressIndicator(color: Colors.orange));
              }

              return Container(
                margin: const EdgeInsets.only(top: 30),
                child: DataTable(
                  columns: _createColumns(),
                  rows: _createRows(),
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isSortAsc,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<DataRow> _createRows() {
    return dataList
        .map((data) => DataRow(
            cells: List.generate(
                sonsorsNames.length,
                (index) =>
                    DataCell(Text(data[sonsorsNames[index]].toString())))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return Column(
        children: [
          Container(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _createDataTable(),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Align(
          alignment: Alignment.center,
          child: Text(
            "No data available",
            style: TextStyle(fontSize: 20),
          ));
    }
  }
}
