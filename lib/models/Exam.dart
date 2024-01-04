import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Exam {
  String? name;
  DateTime? date;
  TimeOfDay? time;
  String? lat;
  String? long;
  String? location;

  Exam({this.name, this.date, this.time, this.lat, this.long, this.location});

  factory Exam.fromJson(Map<String, dynamic> jsonData) {
    return Exam(name: jsonData['name'], date: jsonData['date'] == null ? null : DateTime.parse(jsonData['date']), time: jsonData['time'] == null ? null : TimeOfDay(hour: int.parse(jsonData['time'].split(":")[0]), minute: int.parse(jsonData['time'].split(":")[1].split(" ")[0])), lat: jsonData['lat'] == null ? null : '0.0', long: jsonData['lat'] == null ? null : '0.0', location: jsonData['lat'] == null ? null : jsonData['name'] + 'Location');
  }

  static Map<String, dynamic> toMap(Exam exam) => {
    'name': exam.name,
    'date': exam.date == null ? null : exam.date?.toIso8601String(),
    'time': exam.time == null ? null : formatTimeOfDay(exam.time!),
    'lat': exam.lat,
    'long': exam.long,
    'location': exam.location
  };

  static String encode(List<Exam> exams) => json.encode(
    exams.map<Map<String, dynamic>>((exam) => Exam.toMap(exam)).toList(),
  );

  static List<Exam> decode(String exams) => (json.decode(exams) as List<dynamic>).map<Exam>((item) => Exam.fromJson(item)).toList();

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }
}
