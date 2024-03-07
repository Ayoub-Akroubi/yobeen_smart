import 'package:flutter/material.dart';
import 'package:yobeen_smart/Dashboard/API/api_last_data.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Arbo/Conductivit%C3%A9%20du%20sol/ec.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Arbo/Debit/debit.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Arbo/Dose/dose.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Arbo/Leaf%20wetness/lw.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Arbo/Stock%20Hydrique/sh.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Arbo/Temperature%20de%20sol/st.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Humidite%20Relative/himiditeRelative.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Temperature/temperature.dart';

class ArboCharts extends StatefulWidget {
  const ArboCharts({Key? key}) : super(key: key);

  @override
  State<ArboCharts> createState() => _ArboChartsState();
}

class _ArboChartsState extends State<ArboCharts> {
  //chart Tempurature
  final List<bool> _typeDataT = [false, false, true, false];
  var _indexT = 2;
  bool _visibilityT = false;
  final _chartTempurature = [
    TemperatureChart(type: 'brute'),
    TemperatureChart(type: 'hourly'),
    TemperatureChart(type: 'daily'),
    TemperatureChart(type: 'monthly'),
  ];
  //chart Humidite Relative
  final List<bool> _typeDataRH = [false, false, true, false];
  var _indexRH = 2;
  bool _visibilityRH = false;
  final _chartHumiditeRelative = [
    HumiditeRelative(type: 'brute'),
    HumiditeRelative(type: 'hourly'),
    HumiditeRelative(type: 'daily'),
    HumiditeRelative(type: 'monthly'),
  ];
  //chart ST
  final List<bool> _typeDataST = [false, false, true, false];
  var _indexST = 2;
  bool _visibilityST = false;
  final _chartST = [
    STChart(type: 'brute'),
    STChart(type: 'hourly'),
    STChart(type: 'daily'),
    STChart(type: 'monthly'),
  ];
  //chart SH
  final List<bool> _typeDataSH = [false, false, true, false];
  var _indexSH = 2;
  bool _visibilitySH = false;
  final _chartSH = [
    SHChart(type: 'brute'),
    SHChart(type: 'hourly'),
    SHChart(type: 'daily'),
    SHChart(type: 'monthly'),
  ];
  //chart debit
  final List<bool> _typeDataDebit = [false, false, true, false];
  var _indexDebit = 2;
  bool _visibilityDebit = false;
  final _chartDebit = [
    Debit(type: 'brute'),
    Debit(type: 'hourly'),
    Debit(type: 'daily'),
    Debit(type: 'monthly'),
  ];

  //chart EC
  final List<bool> _typeDataEC = [false, false, true, false];
  var _indexEC = 2;
  bool _visibilityEC = false;
  final _chartEC = [
    ECChart(type: 'brute'),
    ECChart(type: 'hourly'),
    ECChart(type: 'daily'),
    ECChart(type: 'monthly'),
  ];

//chart dose
  final List<bool> _typeDataDose = [false, false, true, false];
  var _indexDose = 2;
  bool _visibilityDose = false;
  final _chartDose = [
    DoseChart(type: 'brute'),
    DoseChart(type: 'hourly'),
    DoseChart(type: 'daily'),
    DoseChart(type: 'monthly'),
  ];
//chart LW
  final List<bool> _typeDataLW = [false, false, true, false];
  var _indexLW = 2;
  bool _visibilityLW = false;
  final _chartLW = [
    LWChart(type: 'brute'),
    LWChart(type: 'hourly'),
    LWChart(type: 'daily'),
    LWChart(type: 'monthly'),
  ];

  List listOfSlug = [];

  void initSonsorsAsync() async {
    await getLastData().then((value) => {
          for (var i = 1; i < value.length; i++)
            {listOfSlug.add(value[i].sensors_slug)},
          if (listOfSlug.contains("T"))
            {
              setState(() {
                _visibilityT = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityT = false;
              }),
            },
          if (listOfSlug.contains("RH"))
            {
              setState(() {
                _visibilityRH = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityRH = false;
              }),
            },
          if (listOfSlug.contains("ST"))
            {
              setState(() {
                _visibilityST = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityST = false;
              }),
            },
          if (listOfSlug.contains("SH"))
            {
              setState(() {
                _visibilitySH = true;
              }),
            }
          else
            {
              setState(() {
                _visibilitySH = false;
              }),
            },
          if (listOfSlug.contains("Debit"))
            {
              setState(() {
                _visibilityDebit = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityDebit = false;
              }),
            },
          if (listOfSlug.contains("dose"))
            {
              setState(() {
                _visibilityDose = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityDose = false;
              }),
            },
          if (listOfSlug.contains("EC"))
            {
              setState(() {
                _visibilityEC = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityEC = false;
              }),
            },
          if (listOfSlug.contains("LW"))
            {
              setState(() {
                _visibilityLW = true;
              }),
            }
          else
            {
              setState(() {
                _visibilityLW = false;
              }),
            },
        });
  }

  @override
  void initState() {
    initSonsorsAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: _visibilityT,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexT', _typeDataT),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartTempurature[_indexT],
              ],
            )),
        //Humidité relative chart
        Visibility(
            visible: _visibilityRH,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexRH', _typeDataRH),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartHumiditeRelative[_indexRH],
              ],
            )),
        // Temperature du sol
        Visibility(
            visible: _visibilityST,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexST', _typeDataST),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartST[_indexST],
              ],
            )),

        // stock hybride
        Visibility(
            visible: _visibilitySH,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexSH', _typeDataSH),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartSH[_indexSH],
              ],
            )),
        // Conductivité du sol
        Visibility(
            visible: _visibilityEC,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexEC', _typeDataEC),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartEC[_indexEC],
              ],
            )),
        // debit
        Visibility(
          visible: _visibilityDebit,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              _toggleButtons('_indexDebit', _typeDataDebit),
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              _chartDebit[_indexDebit],
            ],
          ),
        ),
        // dose
        Visibility(
          visible: _visibilityDose,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              _toggleButtons('_indexDose', _typeDataDose),
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              _chartDose[_indexDose],
            ],
          ),
        ),
        // LW
        Visibility(
          visible: _visibilityLW,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              _toggleButtons('_indexLW', _typeDataLW),
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              _chartLW[_indexLW],
            ],
          ),
        ),
      ],
    );
  }

  ToggleButtons _toggleButtons(value, select) {
    return ToggleButtons(
      children: <Widget>[
        SizedBox(
            width: (MediaQuery.of(context).size.width - 100) / 4.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Brute", style: TextStyle(letterSpacing: 1.0))
              ],
            )),
        SizedBox(
            width: (MediaQuery.of(context).size.width - 50) / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Horaire", style: TextStyle(letterSpacing: 1.0))
              ],
            )),
        SizedBox(
            width: (MediaQuery.of(context).size.width - 50) / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Journalier", style: TextStyle(letterSpacing: 1.0))
              ],
            )),
        SizedBox(
            width: (MediaQuery.of(context).size.width - 50) / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Mensuel", style: TextStyle(letterSpacing: 1.0))
              ],
            )),
      ],
      fillColor: const Color.fromARGB(255, 233, 232, 231),
      isSelected: select,
      borderColor: Colors.orange,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      selectedColor: Colors.orange,
      selectedBorderColor: Colors.orange,
      borderWidth: 1.5,
      onPressed: (int index) {
        setState(() {
          if (value == '_indexT') {
            _indexT = index;
            for (var i = 0; i < _typeDataT.length; i++) {
              if (i == index) {
                _typeDataT[index] = true;
              } else {
                _typeDataT[i] = false;
              }
            }
          }
          if (value == '_indexRH') {
            _indexRH = index;
            for (var i = 0; i < _typeDataRH.length; i++) {
              if (i == index) {
                _typeDataRH[index] = true;
              } else {
                _typeDataRH[i] = false;
              }
            }
          }
          if (value == '_indexEC') {
            _indexEC = index;
            for (var i = 0; i < _typeDataEC.length; i++) {
              if (i == index) {
                _typeDataEC[index] = true;
              } else {
                _typeDataEC[i] = false;
              }
            }
          }
          if (value == '_indexST') {
            _indexST = index;
            for (var i = 0; i < _typeDataST.length; i++) {
              if (i == index) {
                _typeDataST[index] = true;
              } else {
                _typeDataST[i] = false;
              }
            }
          }
          if (value == '_indexSH') {
            _indexSH = index;
            for (var i = 0; i < _typeDataSH.length; i++) {
              if (i == index) {
                _typeDataSH[index] = true;
              } else {
                _typeDataSH[i] = false;
              }
            }
          }
          if (value == '_indexDose') {
            _indexDose = index;
            for (var i = 0; i < _typeDataDose.length; i++) {
              if (i == index) {
                _typeDataDose[index] = true;
              } else {
                _typeDataDose[i] = false;
              }
            }
          }
          if (value == '_indexDebit') {
            _indexDebit = index;
            for (var i = 0; i < _typeDataDebit.length; i++) {
              if (i == index) {
                _typeDataDebit[index] = true;
              } else {
                _typeDataDebit[i] = false;
              }
            }
          }
          if (value == '_indexLW') {
            _indexLW = index;
            for (var i = 0; i < _typeDataLW.length; i++) {
              if (i == index) {
                _typeDataLW[index] = true;
              } else {
                _typeDataLW[i] = false;
              }
            }
          }
        });
      },
    );
  }
}
