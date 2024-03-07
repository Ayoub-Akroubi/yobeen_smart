// ignore_for_file: deprecated_member_use, await_only_futures, avoid_print, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yobeen_smart/Map/API/api_service.dart';
import 'package:yobeen_smart/Navigation/API/api_stations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:yobeen_smart/Map/Model/model_data.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final List _stations = [];
  dynamic _first = "";
  dynamic _x = "";
  dynamic _y = "";
  dynamic _imageMap = "";
  dynamic _typeMap;
  late APIStations apiStations;
  initDropdownAsync() async {
    apiStations = await APIStations();
    apiStations.getStations().then((value) {
      setState(() {
        for (var i = 0; i < value.length; i++) {
          if (value[i]['name_fr'] == null) {
            _stations.add(ModelData(
              serialName: value[i]['serial'].toString() + ' - ',
              x: value[i]['x'].toString(),
              y: value[i]['y'].toString(),
            ));
          } else {
            _stations.add(ModelData(
              serialName: value[i]['serial'].toString() +
                  ' - ' +
                  value[i]['name_fr'].toString(),
              x: value[i]['x'].toString(),
              y: value[i]['y'].toString(),
            ));
          }
          _first = _stations[0].serialName;
        }
      });
    });
  }

  late APIStationsMap apiStationsMap;
  late GoogleMapController mapController;
  late String mapStyle;
  final List<Marker> _markers = [];

  initStateAsync() async {
    apiStationsMap = await APIStationsMap();
    apiStationsMap.getStations().then((value) {
      setState(() {
        for (var i = 0; i < value.length; i++) {
          if (value[i].x == null || value[i].y == null) {
            _markers.add(
              Marker(
                markerId: MarkerId(value[i].serial),
                position: const LatLng(0, 0),
                infoWindow: InfoWindow(
                  title: value[i].serial + ' - ' + value[i].name_fr.toString(),
                  snippet: value[i].name_ar.toString(),
                ),
              ),
            );
          } else {
            _markers.add(
              Marker(
                markerId: MarkerId(value[i].serial),
                position:
                    LatLng(double.parse(value[i].x), double.parse(value[i].y)),
                infoWindow: InfoWindow(
                  title: value[i].serial + ' - ' + value[i].name_fr.toString(),
                  snippet: value[i].name_ar.toString(),
                ),
              ),
            );
          }
        }
      });
    });
  }

  @override
  void initState() {
    initStateAsync();
    initDropdownAsync();
    super.initState();
    _imageMap = 'satillite.jpg';
    _typeMap = MapType.normal;
    DefaultAssetBundle.of(context)
        .loadString('assets/json/style_map.json')
        .then((e) {
      mapStyle = e;
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: _typeMap,
          onMapCreated: mapCreated,
          initialCameraPosition: const CameraPosition(
              target: LatLng(27.42796133580664, -10.085749655962), zoom: 5),
          markers: Set<Marker>.of(_markers),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
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
              items: _stations.map((e) => e.serialName.toString()).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  _first = '$newValue';
                  for (var i = 0; i < _stations.length; i++) {
                    if (newValue == _stations[i].serialName) {
                      _x = _stations[i].x;
                      _y = _stations[i].y;
                    }
                  }
                });
                LatLng newlatlang = LatLng(double.parse(_x), double.parse(_y));
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: newlatlang, zoom: 15)));
              },
              selectedItem: _first,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.only(right: 10, bottom: 100),
              width: 50,
              child: FlatButton(
                  padding: const EdgeInsets.only(right: 0),
                  color: const Color.fromARGB(204, 255, 255, 255),
                  onPressed: () {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        const CameraPosition(
                            target: LatLng(27.42796133580664, -10.085749655962),
                            zoom: 5)));
                  },
                  child: const Icon(Icons.refresh)),
            )),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(bottom: 30),
              height: 80,
              width: 80,
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      if (_typeMap == MapType.normal) {
                        _typeMap = MapType.satellite;
                        _imageMap = "defaultMap.PNG";
                      } else {
                        _imageMap = 'satillite.jpg';
                        _typeMap = MapType.normal;
                      }
                    });
                  },
                  child: Image.asset('./assets/images/image/$_imageMap')),
            ))
      ]),
    );
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      mapController.setMapStyle(mapStyle).then((value) {}).catchError(
          (error) => print("Error setting map style:" + error.toString()));
    });
  }
}
