import 'package:flutter/material.dart';
import 'package:leave_name/Screens/TeamScreen/teamDetail.dart';
import 'package:leave_name/models/team.dart';
import 'package:leave_name/models/user.dart';
import './teamDetail.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'My Teams',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
            iconSize: 30.0,
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Text(
                'Add +',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () => {},
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              itemCount: _teamList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _teamCard(context, index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _teamCard(BuildContext context, int index) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.blue[100]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamDetail(),
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  _teamList[index].emoji,
                  style: TextStyle(fontSize: 100),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _teamList[index].name,
                  style: TextStyle(fontSize: 36),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Team> _teamList = [
  Team(
    name: 'Bridge',
    teamCaps: [
      User(
        floorName: 'YCW',
        floor: 7,
        room: '710A',
        hallYear: 2,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/JunJul.JPG',
      ),
    ],
    teammates: [
      User(
        floorName: 'OP',
        floor: 8,
        room: '807',
        hallYear: 3,
        academicYear: 4,
        curriculum: 'BEng(CS)',
        proPic: 'assets/images/AugSep.JPG',
      ),
      User(
        floorName: 'Linchy',
        floor: 5,
        room: '509',
        hallYear: 4,
        academicYear: 4,
        curriculum: 'BA',
        proPic: 'assets/images/OctNov.JPG',
      ),
      User(
        floorName: 'Mw',
        floor: 3,
        room: '305',
        hallYear: 4,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/DecJan.JPG',
      ),
      User(
        floorName: 'YCW',
        floor: 7,
        room: '710A',
        hallYear: 2,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/JunJul.JPG',
      ),
    ],
    emoji: '♠️',
  ),
  Team(
    name: 'Tennis',
    teamCaps: [
      User(
        floorName: 'YCW',
        floor: 7,
        room: '710A',
        hallYear: 2,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/JunJul.JPG',
      ),
    ],
    teammates: [
      User(
        floorName: 'OP',
        floor: 8,
        room: '807',
        hallYear: 3,
        academicYear: 4,
        curriculum: 'BEng(CS)',
        proPic: 'assets/images/AugSep.JPG',
      ),
      User(
        floorName: 'Linchy',
        floor: 5,
        room: '509',
        hallYear: 4,
        academicYear: 4,
        curriculum: 'BA',
        proPic: 'assets/images/OctNov.JPG',
      ),
      User(
        floorName: 'Mw',
        floor: 3,
        room: '305',
        hallYear: 4,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/DecJan.JPG',
      ),
      User(
        floorName: 'YCW',
        floor: 7,
        room: '710A',
        hallYear: 2,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/JunJul.JPG',
      ),
    ],
    emoji: '🎾',
  ),
  Team(
    name: 'Hockey',
    teamCaps: [
      User(
        floorName: 'YCW',
        floor: 7,
        room: '710A',
        hallYear: 2,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/JunJul.JPG',
      ),
    ],
    teammates: [
      User(
        floorName: 'OP',
        floor: 8,
        room: '807',
        hallYear: 3,
        academicYear: 4,
        curriculum: 'BEng(CS)',
        proPic: 'assets/images/AugSep.JPG',
      ),
      User(
        floorName: 'Linchy',
        floor: 5,
        room: '509',
        hallYear: 4,
        academicYear: 4,
        curriculum: 'BA',
        proPic: 'assets/images/OctNov.JPG',
      ),
      User(
        floorName: 'Mw',
        floor: 3,
        room: '305',
        hallYear: 4,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/DecJan.JPG',
      ),
      User(
        floorName: 'YCW',
        floor: 7,
        room: '710A',
        hallYear: 2,
        academicYear: 5,
        curriculum: 'MBBS',
        proPic: 'assets/images/JunJul.JPG',
      ),
    ],
    emoji: '🏑',
  ),
];
