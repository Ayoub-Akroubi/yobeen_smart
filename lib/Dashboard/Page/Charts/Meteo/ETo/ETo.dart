// ignore_for_file: await_only_futures, unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:high_chart/high_chart.dart';
import 'package:yobeen_smart/Dashboard/API/api_chart.dart';
import 'package:yobeen_smart/Dashboard/API/api_sonsors.dart';

class EToChart extends StatefulWidget {
  dynamic type;
  EToChart({Key? key, required this.type}) : super(key: key);

  @override
  _EToChartState createState() => _EToChartState();
}

class _EToChartState extends State<EToChart> {
  late APIChart apiChart;
  String _name = '';
  String _color = '';
  String _unity = '';
  dynamic dataChartBrute = [];
  dynamic dataChartHourly = [];
  dynamic dataChartDaily = [];
  dynamic dataChartMonthly = [];
  dynamic dataChart = [];
  List types = ['brute', 'hourly', 'daily', 'monthly'];
  List listOfSlug = [];

  initStateAsync() async {
    apiChart = await APIChart();
    for (var j = 0; j < types.length; j++) {
      apiChart.fetchData(types[j]).then((value) => {
            if (mounted)
              setState(() {
                for (var i = 0; i < value.length; i++) {
                  if (types[j] == 'brute') {
                    final datetimevalue = DateTime.parse(value[i]['datetime']);
                    final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                    dataChartBrute.add([timestamp1, value[i]['ETo']]);
                  } else if (types[j] == 'hourly') {
                    final datetimevalue = DateTime.parse(value[i]['datetime']);
                    final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                    dataChartHourly.add([timestamp1, value[i]['ETo']]);
                  } else if (types[j] == 'daily') {
                    final datetimevalue = DateTime.parse(value[i]['datetime']);
                    final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                    dataChartDaily.add([timestamp1, value[i]['ETo']]);
                  } else if (types[j] == 'monthly') {
                    final datetimevalue = DateTime.parse(value[i]['datetime']);
                    final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                    dataChartMonthly.add([timestamp1, value[i]['ETo']]);
                  }
                }
              })
          });
    }

    APISonsors apiLastData = await new APISonsors();
    apiLastData.fetchSonsors().then((value) => {
          setState(() {
            for (var i = 0; i < value.length; i++) {
              if (value[i]["slug"] == 'ETo') {
                _name = value[i]['name'];
                _color = value[i]['color'];
                _unity = value[i]['unity'];
              }
            }
          }),
        });
  }

  @override
  void initState() {
    initStateAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'brute') {
      dataChart = dataChartBrute;
    } else if (widget.type == 'hourly') {
      dataChart = dataChartHourly;
    } else if (widget.type == 'daily') {
      dataChart = dataChartDaily;
    } else if (widget.type == 'monthly') {
      dataChart = dataChartMonthly;
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(5),
          child: HighCharts(
            loader: const SizedBox(
              child: LinearProgressIndicator(),
              width: double.infinity,
            ),
            size: const Size(double.infinity, 410),
            data: '''
                {
                  credits:{
                  text: 'yobeen.com',
                  href:'www.yobeen.com',
                  style:{
                    color:'#ff8d00'
                  }
                },
                  chart: {
                      type: 'column',
                       zoomType: 'x'
                  },
                  title: {
                      text: ''
                  },
                  
                exporting:{
                  enabled: false
                },
                    xAxis: {
                    type: 'datetime',
                    accessibility: {
                    }
                },
                  yAxis: [{
                      title: {
                        text: ''
                      }
                  }],
                  plotOptions: {
                      column: {
                        borderRadius: 5,

                      }
                  },
                  series: [{
                    name: '$_name ($_unity)',
                    color: '$_color',
                    data: $dataChart,
                      
                  }]
              }
              ''',
            scripts: const [
              'https://code.highcharts.com/highcharts.js',
              'https://code.highcharts.com/highcharts-more.js',
              'https://code.highcharts.com/modules/exporting.js',
              'https://code.highcharts.com/modules/export-data.js',
              'https://code.highcharts.com/modules/accessibility.js',
            ],
          ),
        ),
      ],
    );
  }
}
