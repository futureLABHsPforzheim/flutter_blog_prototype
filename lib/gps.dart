import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:convert';

class Gps extends StatefulWidget {
  @override
  _GpsState createState() => new _GpsState();
}

class _GpsState extends State<Gps> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;
  String loc;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  bool _permission = false;
  String error;
  double lng;
  double lat;
  double alt;
  double speed;

  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    super.initState();

    initPlatformState();
   
    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        lng = result["longitude"];
        lat = result['latitude'];
        alt = result['altitude'];
        speed = result['speed'];
        _currentLocation = result;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _startLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;
    widgets = new List();
    /*
    if (_currentLocation == null) {
      widgets = new List();
    } else {
      widgets = [
        new Image.network(
            "https://maps.googleapis.com/maps/api/staticmap?center=${_currentLocation["latitude"]},${_currentLocation["longitude"]}&zoom=18&size=640x400&key=AIzaSyA_RBNPnGkvfp_3lPOxQoyFk9mkQ1T_mxY")
      ];
    }
    */

    widgets.add(
      new Text(
          _startLocation != null ? 'Longitutde: $lng\n' : 'Error: $error\n',
          style: TextStyle(
            fontSize: 30,
          )),
    );

    widgets.add(new Text(
        _currentLocation != null ? 'Latutude: $lat\n' : 'Error: $error\n',
        style: TextStyle(
          fontSize: 30,
        )));
    widgets.add(new Text(
        _currentLocation != null ? 'Altitude: $alt\n' : 'Error: $error\n',
        style: TextStyle(
          fontSize: 30,
        )));
    widgets.add(new Text(
        _currentLocation != null ? 'Speed: $speed\n' : 'Error: $error\n',
        style: TextStyle(
          fontSize: 30,
        )));

     return new Container(
      margin: const EdgeInsets.only(top: 200.0),
      color: Colors.white30,
      child: new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: widgets),
    );
  }
}
