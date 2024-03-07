// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, await_only_futures, unnecessary_new

import 'package:flutter/material.dart';
import 'package:high_chart/high_chart.dart';
import 'package:yobeen_smart/Dashboard/API/api_chart.dart';
import 'package:yobeen_smart/Dashboard/API/api_sonsors.dart';

class RayonnementGlobalChart extends StatefulWidget {
  dynamic type;
  RayonnementGlobalChart({Key? key, required this.type}) : super(key: key);

  @override
  State<RayonnementGlobalChart> createState() => _RayonnementGlobalChartState();
}

class _RayonnementGlobalChartState extends State<RayonnementGlobalChart> {
  late APIChart apiChart;
  String _name = '';
  String _color = '';
  String _unity = '';
  bool _error = true;
  dynamic dataChartBrute = [];
  dynamic dataChartHourly = [];
  dynamic dataChartDaily = [];
  dynamic dataChartMonthly = [];
  dynamic dataChart = [];
  List types = ['brute', 'hourly', 'daily', 'monthly'];
  List listOfSlug = [];

  initStateAsync() async {
    apiChart = await new APIChart();
    for (var j = 0; j < types.length; j++) {
      apiChart.fetchData(types[j]).then((value) => {
            if (value.isEmpty)
              {
                setState(() {
                  _error = true;
                }),
              }
            else
              {
                setState(() {
                  _error = false;
                  for (var i = 0; i < value.length; i++) {
                    if (types[j] == 'brute') {
                      final datetimevalue =
                          DateTime.parse(value[i]['datetime']);
                      final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                      dataChartBrute.add([timestamp1, value[i]['SR']]);
                    }
                    if (types[j] == 'hourly') {
                      final datetimevalue =
                          DateTime.parse(value[i]['datetime']);
                      final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                      dataChartHourly.add([timestamp1, value[i]['SR']]);
                    }
                    if (types[j] == 'daily') {
                      final datetimevalue =
                          DateTime.parse(value[i]['datetime']);
                      final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                      dataChartDaily.add([timestamp1, value[i]['SR']]);
                    } else if (types[j] == 'monthly') {
                      final datetimevalue =
                          DateTime.parse(value[i]['datetime']);
                      final timestamp1 = datetimevalue.millisecondsSinceEpoch;
                      dataChartMonthly.add([timestamp1, value[i]['SR']]);
                    }
                  }
                })
              }
          });
    }

    APISonsors apiLastData = await new APISonsors();
    apiLastData.fetchSonsors().then((value) => {
          if (value.isEmpty)
            {
              setState(() {
                _error = true;
              }),
            }
          else
            {
              setState(() {
                for (var i = 0; i < value.length; i++) {
                  listOfSlug.add(value[i]["slug"]);
                }
                if (listOfSlug.contains('SR')) {
                  setState(() {
                    _error = false;
                  });
                  for (var i = 0; i < value.length; i++) {
                    if (value[i]["slug"] == 'SR') {
                      _name = value[i]['name'];
                      _color = value[i]['color'];
                      _unity = value[i]['unity'];
                    }
                  }
                } else {
                  setState(() {
                    _error = true;
                  });
                }
              }),
            }
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
    if (_error) {
      return Container();
    } else {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            child: HighCharts(
              loader: SizedBox(
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
                        zoomType: 'x'
                    },
                    title: {
                        text: '',
                         zoomType: 'x'
                    },
                  
                exporting:{
                  enabled: false
                },
                    xAxis: {
                        type: 'datetime'
                    },
                    yAxis: {
                        title: {
                            text: ''
                        }
                    },
                    legend: {
                        enabled: true
                      
                    },
                    plotOptions: {
                        area: {
                            fillColor: {
                                linearGradient: {
                                    x1: 0,
                                    y1: 0,
                                    x2: 0,
                                    y2: 1
                                },
                                stops: [
                                    [0, '$_color'],
                                    [1, '$_color']
                                ]
                            },
                            marker: {
                                radius: 2
                            },
                            lineWidth: 1,
                            states: {
                                hover: {
                                    lineWidth: 1
                                }
                            },
                            threshold: null
                        }
                    },

                    series: [{
                        type: 'area',
                        name: '$_name ($_unity)',
                        color:'$_color',
                        data: $dataChart
                    }]
                  }
            ''',
              scripts: [
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
}
