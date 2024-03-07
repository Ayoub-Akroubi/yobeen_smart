// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:yobeen_smart/Dashboard/API/api_last_data.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts%20by%20type/Arbo/ArboCharts.dart';
import 'package:yobeen_smart/Dashboard/Page/Charts%20by%20type/Metoe/chartMeteo.dart';
import 'package:yobeen_smart/Dashboard/Page/last_data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic serial = "";

  bool _error = false;
  bool _arbovisibilty = false;
  bool _meteovisibilty = false;
  List listOfSlug = [];
  initStateAsync() async {
    await getLastData().then((value) => {
          if (value.isEmpty)
            {
              if (mounted)
                {
                  setState(() {
                    _error = true;
                  }),
                }
            }
          else
            {
              if (mounted)
                {
                  setState(() {
                    _error = false;
                  })
                }
            }
        });
  }

  void initSonsorsAsync() async {
    APILastData apiLastData = await new APILastData();
    apiLastData.fetchLastData().then((value) {
      if (value['info_device']['category'] == 'meteo') {
        setState(() {
          _meteovisibilty = true;
          _arbovisibilty = false;
        });
      } else if (value['info_device']['category'] == 'arbo') {
        setState(() {
          _meteovisibilty = false;
          _arbovisibilty = true;
        });
      }
    });
  }

  @override
  void initState() {
    initStateAsync();
    initSonsorsAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Align(
          alignment: Alignment.center,
          child: Text(
            "No data available",
            style: TextStyle(fontSize: 20),
          ));
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 4 / 100,
                vertical: MediaQuery.of(context).size.height * 1 / 100),
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              LastData(),
              Visibility(
                visible: _meteovisibilty,
                child: ChartsMeteo(),
              ),
              Visibility(
                visible: _arbovisibilty,
                child: ArboCharts(),
              ),
            ]),
          )
        ]),
      );
    }
  }
}
