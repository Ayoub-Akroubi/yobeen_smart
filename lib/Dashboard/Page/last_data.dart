// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:yobeen_smart/Dashboard/API/api_last_data.dart';
import 'package:yobeen_smart/Dashboard/Model/lastDataModel.dart';

class LastData extends StatefulWidget {
  const LastData({Key? key}) : super(key: key);

  @override
  State<LastData> createState() => _LastDataState();
}

class _LastDataState extends State<LastData> {
  List<LastDataModel> _lastData = [];
  List valueData = [];

  void initStateAsyncSecond() async {
    await getLastData().then((value) => {
          if (mounted)
            {
              setState(() {
                _lastData.clear();
                _lastData = value;
              }),
            }
        });
  }

  @override
  void initState() {
    initStateAsyncSecond();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 39, 39, 39).withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Column(children: [
              Column(
                children: List.generate(_lastData.length, (index) {
                  return Container(
                    padding: const EdgeInsets.all(7),
                    child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(4),
                          3: FlexColumnWidth(1.5),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Container(
                                height: 32,
                                width: 32,
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.network(
                                    _lastData[index].sensors_icon),
                              )
                            ]),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(children: [
                                Text(_lastData[index].sensors_name.toString(),
                                    style: const TextStyle(fontSize: 14.0))
                              ]),
                            ),
                            Column(children: [
                              Text(_lastData[index].value.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14.0))
                            ]),
                            Column(children: [
                              Text(_lastData[index].sensors_unity.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14.0))
                            ]),
                          ]),
                        ]),
                  );
                }),
              ),
            ])
          ],
        ));
  }
}
