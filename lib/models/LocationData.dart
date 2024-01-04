import 'package:flutter/material.dart';

class LocationData {
  String? description;
  double? latitude;
  double? longitude;
  double? accuracy;
  double? altitude;
  double? speed;
  double? speedAccuracy;
  double? heading;
  double? time;
  bool? isMock;

  LocationData({this.description, this.latitude, this.longitude});
}

enum LocationAccuracy { powerSave, low, balanced, high, navigation }

enum PermissionStatus { granted, denied, deniedForever }
