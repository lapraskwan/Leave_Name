// import 'package:flutter/material.dart';

class User {
  int userId;
  String username;
  String password;
  String profilePic;
  String floorName;
  String realName;
  int floor;
  String room;
  String uid;
  int graduated;
  int hallYear;
  int academicYear;
  String curriculum;
  String expectedGradYear;
  double cgpa;
  DateTime birthday;
  String status;
  String email;
  String phoneNumber;
  // List<Course> coursesTaken;
  // List<Course> coursesThisSem;

  User({
    this.userId,
    this.username,
    this.password,
    this.profilePic,
    this.floorName,
    this.realName,
    this.floor,
    this.room,
    this.uid,
    this.graduated,
    this.hallYear,
    this.academicYear,
    this.curriculum,
    this.expectedGradYear,
    this.cgpa,
    this.birthday,
    this.status,
    this.email,
    this.phoneNumber,
  }); 

  User.fromJson(Map<String, dynamic> json) 
    : userId = json['user_id'],
      username = json['username'],
      password = json['password'],
      profilePic = json['profile_pic'],
      floorName = json['floor_name'],
      realName = json['real_name'],
      floor = json['floor'],
      room = json['room'],
      uid = json['uid'],
      graduated = json['graduated'],
      hallYear = json['hall_year'],
      academicYear = json['academic_year'],
      curriculum = json['curriculum'],
      expectedGradYear = json['expected_grad_year'],
      cgpa = json['cgpa'],
      birthday = DateTime.parse(json['birthday']),
      status = json['status'],
      email = json['email'],
      phoneNumber = json['phone_number'];
}
