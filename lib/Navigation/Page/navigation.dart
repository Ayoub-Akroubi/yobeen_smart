// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_new, deprecated_member_use, unused_field, prefer_collection_literals, prefer_const_constructors_in_immutables, avoid_print, await_only_futures

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:yobeen_smart/Dashboard/Page/dashboard.dart';
import 'package:yobeen_smart/Dashboard/Page/dashboard_reload.dart';
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';
import 'package:yobeen_smart/Login/Pages/login_screen.dart';
import 'package:yobeen_smart/Map/Page/map.dart';
import 'package:yobeen_smart/Navigation/API/api_stations.dart';
import 'package:yobeen_smart/Tableau/Page/tableau_reload.dart';
import 'package:yobeen_smart/Tableau/Page/tableau_screen.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int _currentPage = 0;
  int _selectedPage = 0;
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

  initSerialInLocalStorage() async {
    apiStations = await APIStations();
    apiStations.getStations().then((value) {
      setState(() {
        LocalStorage.saveSerial(value[0]["serial"]);
      });
    });
  }

  @override
  void initState() {
    initSerialInLocalStorage();
    initStateAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      Dashboard(),
      Map(),
      Tableau(),
      DashboardReload(),
      TableauRelaod(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset(
          "./assets/images/logo/logo.png",
          width: 90,
        ),
        backgroundColor: Color.fromARGB(255, 70, 69, 69),
        actions: [
          IconButton(
              onPressed: () {
                LocalStorage.deleteSerial();
                LocalStorage.deleteToken();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      drawer: Drawer(
        child: Material(
          child: ListView(
            children: [
              Container(
                color: Color.fromARGB(255, 70, 69, 69),
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  "./assets/images/logo/logo.png",
                  width: 90,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0)),
              ListTile(
                leading: Icon(Icons.dashboard, color: Colors.black),
                title: Text('Dashboard', style: TextStyle(color: Colors.black)),
                hoverColor: Colors.white70,
                onTap: () => {
                  Navigator.pop(context),
                  setState(() =>
                      {_selectedPage = 0, _currentPage = 0, _visibility = true})
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListTile(
                leading: Icon(Icons.mode_of_travel_sharp, color: Colors.black),
                title: Text('Maps', style: TextStyle(color: Colors.black)),
                hoverColor: Colors.white70,
                onTap: () => {
                  Navigator.pop(context),
                  setState(() => {
                        _selectedPage = 1,
                        _currentPage = 1,
                        _visibility = false
                      })
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListTile(
                leading: Icon(Icons.table_rows_sharp, color: Colors.black),
                title: Text('Tableau', style: TextStyle(color: Colors.black)),
                hoverColor: Colors.white70,
                onTap: () => {
                  Navigator.pop(context),
                  setState(() =>
                      {_selectedPage = 2, _currentPage = 2, _visibility = true})
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: _visibility,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange, width: 2),
                    color: Colors.amber[100]),
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
                        if (_currentPage == 0 || _currentPage == 3) {
                          if (newValue == _stationList[i]) {
                            if (_currentPage == 0) {
                              _currentPage = 3;
                            } else if (_currentPage == 3) {
                              _currentPage = 0;
                            }
                            _selectedPage = 0;
                            LocalStorage.deleteSerial();
                            LocalStorage.saveSerial(
                                _stationSerial[i].toString());
                          }
                        } else if (_currentPage == 2 || _currentPage == 4) {
                          if (newValue == _stationList[i]) {
                            if (_currentPage == 2) {
                              _currentPage = 4;
                            } else if (_currentPage == 4) {
                              _currentPage = 2;
                            }
                            _selectedPage = 2;
                            LocalStorage.deleteSerial();
                            LocalStorage.saveSerial(
                                _stationSerial[i].toString());
                          }
                        }
                      }
                    });
                  },
                  selectedItem: _first,
                ),
              ),
            ),
          ),
          Expanded(child: screens[_currentPage]),
        ],
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedPage,
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.dashboard),
            activeColor: Colors.orange,
            title: Text('Dashbord'),
          ),
          BottomBarItem(
            icon: Icon(Icons.map),
            activeColor: Colors.orange,
            title: Text('Map'),
          ),
          BottomBarItem(
            icon: Icon(Icons.table_rows_rounded),
            activeColor: Colors.orange,
            title: Text('Tableau'),
          ),
        ],
        onTap: (int value) {
          setState(() => {
                if (value == 1) {_visibility = false} else {_visibility = true},
                _selectedPage = value,
                _currentPage = value
              });
        },
      ),
    );
  }
}
