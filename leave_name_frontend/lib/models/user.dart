// import 'package:flutter/material.dart';

class User {
  String username;
  String password;
  String proPic;
  String floorName;
  String realName;
  int floor;
  String room;
  String uid;
  int hallYear;
  int academicYear;
  String curriculum;
  int expectedGradYear;
  double cgpa;
  List<double> gpa;
  List<String> teams;
  DateTime bday;
  String status;
  String email;
  int phone;
  // List<Course> coursesTaken;
  // List<Course> coursesThisSem;

  User({
    this.username,
    this.password,
    this.proPic,
    this.floorName,
    this.realName,
    this.floor,
    this.room,
    this.uid,
    this.hallYear,
    this.academicYear,
    this.curriculum,
    this.expectedGradYear,
    this.cgpa,
    this.gpa,
    this.teams,
    this.bday,
    this.status,
    this.email,
    this.phone,
  });


}
