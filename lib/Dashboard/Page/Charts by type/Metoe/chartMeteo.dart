import 'package:flutter/material.dart';
import 'package:yobeen_smart/Dashboard/API/api_last_data.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/DeltaT/deltaT.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/ETo/ETo.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Energie%20solaire/energie_solaire.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Humidite%20Relative/himiditeRelative.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Point%20de%20rosee/point_de_rosee.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Precipitation/precipitation.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Rayonnement%20Global/RayonnementGlobal.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Temperature/temperature.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/VPD/vpd.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts/Meteo/Vitesse%20de%20vent/vitesseDeVent.dart';

class ChartsMeteo extends StatefulWidget {
  const ChartsMeteo({Key? key}) : super(key: key);

  @override
  State<ChartsMeteo> createState() => _ChartsMeteoState();
}

class _ChartsMeteoState extends State<ChartsMeteo> {
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
  //chart Rayonnement global
  final List<bool> _typeDataSR = [false, false, true, false];
  var _indexSR = 2;
  bool _visibilitySR = false;
  final _chartSR = [
    RayonnementGlobalChart(type: 'brute'),
    RayonnementGlobalChart(type: 'hourly'),
    RayonnementGlobalChart(type: 'daily'),
    RayonnementGlobalChart(type: 'monthly')
  ];
  //chart Vitesse de vent
  final List<bool> _typeDataWS = [false, false, true, false];
  var _indexWS = 2;
  bool _visibilityWS = false;
  final _chartWS = [
    VitesseDeVentChart(type: 'brute'),
    VitesseDeVentChart(type: 'hourly'),
    VitesseDeVentChart(type: 'daily'),
    VitesseDeVentChart(type: 'monthly'),
  ];
  //chart Precipitation
  final List<bool> _typeDataRain = [false, false, true, false];
  var _indexRain = 2;
  bool _visibilityRain = false;
  final _chartRain = [
    Precipitation(type: 'brute'),
    Precipitation(type: 'hourly'),
    Precipitation(type: 'daily'),
    Precipitation(type: 'monthly'),
  ];
  //chart ETo
  final List<bool> _typeDataETo = [false, false, true, false];
  var _indexETo = 2;
  bool _visibilityETo = false;
  final _chartETo = [
    EToChart(type: 'brute'),
    EToChart(type: 'hourly'),
    EToChart(type: 'daily'),
    EToChart(type: 'monthly'),
  ];

//chart Energie solaire global
  final List<bool> _typeDataES = [false, false, true, false];
  var _indexES = 2;
  bool _visibilityES = false;
  final _chartES = [
    EnergieSolaireChart(type: 'brute'),
    EnergieSolaireChart(type: 'hourly'),
    EnergieSolaireChart(type: 'daily'),
    EnergieSolaireChart(type: 'monthly'),
  ];
  //chart DeltaT
  final List<bool> _typeDataDeltaT = [false, false, true, false];
  var _indexDeltaT = 2;
  bool _visibilityDeltaT = false;
  final _chartDeltaT = [
    DeltaTChart(type: 'brute'),
    DeltaTChart(type: 'hourly'),
    DeltaTChart(type: 'daily'),
    DeltaTChart(type: 'monthly'),
  ];

//chart Point de rosée
  final List<bool> _typeDataDewpoint = [false, false, true, false];
  var _indexDewpoint = 2;
  bool _visibilityDewpoint = false;
  final _chartDewpoint = [
    PointDeRoseeChart(type: 'brute'),
    PointDeRoseeChart(type: 'hourly'),
    PointDeRoseeChart(type: 'daily'),
    PointDeRoseeChart(type: 'monthly'),
  ];

  //chart VPD
  final List<bool> _typeDataVpd = [false, false, true, false];
  var _indexVpd = 2;
  bool _visibilityVpd = false;
  final _chartVpd = [
    VPDChart(type: 'brute'),
    VPDChart(type: 'hourly'),
    VPDChart(type: 'daily'),
    VPDChart(type: 'monthly'),
  ];

  List listOfSlug = [];
  void initSonsorsAsync() async {
    await getLastData().then((value) => {
          for (var i = 1; i < value.length; i++)
            {listOfSlug.add(value[i].sensors_slug)},
          if (listOfSlug.contains('T'))
            {
              setState(() {
                _visibilityT = true;
              })
            }
          else
            {
              {
                setState(() {
                  _visibilityT = false;
                })
              }
            },
          if (listOfSlug.contains('RH'))
            {
              setState(() {
                _visibilityRH = true;
              })
            }
          else
            {
              setState(() {
                _visibilityRH = false;
              })
            },
          if (listOfSlug.contains('SR'))
            {
              setState(() {
                _visibilitySR = true;
              })
            }
          else
            {
              setState(() {
                _visibilitySR = false;
              })
            },
          if (listOfSlug.contains('WS'))
            {
              setState(() {
                _visibilityWS = true;
              })
            }
          else
            {
              setState(() {
                _visibilityWS = false;
              })
            },
          if (listOfSlug.contains('Rain'))
            {
              setState(() {
                _visibilityRain = true;
              })
            }
          else
            {
              setState(() {
                _visibilityRain = false;
              })
            },
          if (listOfSlug.contains('ETo'))
            {
              setState(() {
                _visibilityETo = true;
              })
            }
          else
            {
              setState(() {
                _visibilityETo = false;
              })
            },
          if (listOfSlug.contains('ES'))
            {
              setState(() {
                _visibilityES = true;
              })
            }
          else
            {
              setState(() {
                _visibilityES = false;
              })
            },
          if (listOfSlug.contains('DeltaT'))
            {
              setState(() {
                _visibilityDeltaT = true;
              })
            }
          else
            {
              setState(() {
                _visibilityDeltaT = false;
              })
            },
          if (listOfSlug.contains('dewpoint'))
            {
              setState(() {
                _visibilityDewpoint = true;
              })
            }
          else
            {
              setState(() {
                _visibilityDewpoint = false;
              })
            },
          if (listOfSlug.contains('vpd'))
            {
              setState(() {
                _visibilityVpd = true;
              })
            }
          else
            {
              setState(() {
                _visibilityVpd = false;
              })
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
        // Temperature chart
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
        //Rayonnement Global chart
        Visibility(
            visible: _visibilitySR,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexSR', _typeDataSR),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartSR[_indexSR],
              ],
            )),
        //Rayonnement Global chart
        Visibility(
            visible: _visibilityWS,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexWS', _typeDataWS),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartWS[_indexWS],
              ],
            )),
        //Précipitation chart

        Visibility(
            visible: _visibilityRain,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexRain', _typeDataRain),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartRain[_indexRain],
              ],
            )),
        //ETo chart
        Visibility(
            visible: _visibilityETo,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexETo', _typeDataETo),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartETo[_indexETo],
              ],
            )),
        //Energie solaire global chart
        Visibility(
            visible: _visibilityES,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexES', _typeDataES),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartES[_indexES],
              ],
            )),
        // DeltaT chart
        Visibility(
            visible: _visibilityDeltaT,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexDeltaT', _typeDataDeltaT),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartDeltaT[_indexDeltaT],
              ],
            )),
        // Point de rosée chart
        Visibility(
            visible: _visibilityDewpoint,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexDewpoint', _typeDataDewpoint),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartDewpoint[_indexDewpoint],
              ],
            )),
        // VPD chart
        Visibility(
            visible: _visibilityVpd,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _toggleButtons('_indexVpd', _typeDataVpd),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                _chartVpd[_indexVpd],
              ],
            )),
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
          if (value == '_indexSR') {
            _indexSR = index;
            for (var i = 0; i < _typeDataSR.length; i++) {
              if (i == index) {
                _typeDataSR[index] = true;
              } else {
                _typeDataSR[i] = false;
              }
            }
          }
          if (value == '_indexWS') {
            _indexWS = index;
            for (var i = 0; i < _typeDataWS.length; i++) {
              if (i == index) {
                _typeDataWS[index] = true;
              } else {
                _typeDataWS[i] = false;
              }
            }
          }
          if (value == '_indexRain') {
            _indexRain = index;
            for (var i = 0; i < _typeDataRain.length; i++) {
              if (i == index) {
                _typeDataRain[index] = true;
              } else {
                _typeDataRain[i] = false;
              }
            }
          }
          if (value == '_indexETo') {
            _indexETo = index;
            for (var i = 0; i < _typeDataETo.length; i++) {
              if (i == index) {
                _typeDataETo[index] = true;
              } else {
                _typeDataETo[i] = false;
              }
            }
          }
          if (value == '_indexES') {
            _indexES = index;
            for (var i = 0; i < _typeDataES.length; i++) {
              if (i == index) {
                _typeDataES[index] = true;
              } else {
                _typeDataES[i] = false;
              }
            }
          }
          if (value == '_indexDeltaT') {
            _indexDeltaT = index;
            for (var i = 0; i < _typeDataDeltaT.length; i++) {
              if (i == index) {
                _typeDataDeltaT[index] = true;
              } else {
                _typeDataDeltaT[i] = false;
              }
            }
          }
          if (value == '_indexDewpoint') {
            _indexDewpoint = index;
            for (var i = 0; i < _typeDataDewpoint.length; i++) {
              if (i == index) {
                _typeDataDewpoint[index] = true;
              } else {
                _typeDataDewpoint[i] = false;
              }
            }
          }
          if (value == '_indexVpd') {
            _indexVpd = index;
            for (var i = 0; i < _typeDataVpd.length; i++) {
              if (i == index) {
                _typeDataVpd[index] = true;
              } else {
                _typeDataVpd[i] = false;
              }
            }
          }
        });
      },
    );
  }
}
