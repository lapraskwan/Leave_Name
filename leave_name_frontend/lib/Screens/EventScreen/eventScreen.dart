import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:leave_name/models/event.dart';

class EventScreen extends StatefulWidget {
  final int eventId;
  EventScreen(this.eventId);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Event _eventObject;
  String _nameOfFloor;
  String _nameOfTeam;

  String _toCustomDateMonth(DateTime dateTime) {
    return dateTime.day.toString() +
        '/' +
        dateTime.month.toString() +
        ' (' +
        DateFormat.E().format(dateTime) +
        ')';
  }

  Future _fetchEventDetails(int eventId) async {
    var url =
        "http://localhost:3000/event/getByAttr?attr=event.event_id&value=" +
            eventId.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _eventJson = json.decode(response.body);
      if (_eventJson[0]['floor'] != null) {
        _eventObject = FloorEvent.fromJson(_eventJson[0]);
      } else if (_eventJson[0]['team_id'] != null) {
        _eventObject = TeamEvent.fromJson(_eventJson[0]);
      } else if (_eventJson[0]['stage'] != null) {
        // Interhall aquatics and athletics may not have specific opponents
        _eventObject = InterhallEvent.fromJson(_eventJson[0]);
      } else {
        // Normal hall event
        _eventObject = Event.fromJson(_eventJson[0]);
      }
      return response;
    } else {
      throw Exception("Failed to load event details");
    }
  }

  Future _fetchFloorName(int floor) async {
    var url = "http://localhost:3000/floor/getByAttr?attr=floor_id&value=" +
        floor.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var floorJson = json.decode(response.body);
      floorJson[0]['name_en'] == null
          ? _nameOfFloor = floorJson[0]['name_ch']
          : _nameOfFloor = floorJson[0]['name_en'];
      return response;
    } else {
      throw Exception("Failed to load floor name");
    }
  }

  Future _fetchTeamName(int teamId) async {
    var url = "http://localhost:3000/team/getByAttr?attr=team_id&value=" +
        teamId.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var teamJson = json.decode(response.body);
      _nameOfTeam = teamJson[0]['name'];
      return response;
    } else {
      throw Exception("Failed to load team name");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchEventDetails(widget.eventId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: _eventType(),
                leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                  iconSize: 30.0,
                ),
              ),
              Image(
                width: MediaQuery.of(context).size.width,
                image: AssetImage(_eventObject.poster),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  _eventObject.type == 'interhall'
                      ? (_eventObject as InterhallEvent).team +
                          ' ' +
                          (_eventObject as InterhallEvent).stage +
                          ' vs ' +
                          (_eventObject as InterhallEvent).opponent
                      : _eventObject.title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Date',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        _toCustomDateMonth(_eventObject.startTime),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Starting Time',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        DateFormat.Hm()
                            .format(_eventObject.startTime)
                            .toString(),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Venue',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        _eventObject.venue,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              _eventObject.dressCode == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Dress Code',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              _eventObject.dressCode,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
              _eventObject.dressCode == null ? SizedBox.shrink() : Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Description:',
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      _eventObject.description,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else
          return CircularProgressIndicator();
      },
    );
  }

  Widget _eventType() {
    if (_eventObject.type == 'floor') {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: FutureBuilder(
          future: _fetchFloorName((_eventObject as FloorEvent).floor),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(
                _nameOfFloor,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            } else
              return CircularProgressIndicator();
          },
        ),
      );
    } else if (_eventObject.type == 'team') {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: FutureBuilder(
          future: _fetchTeamName((_eventObject as TeamEvent).teamId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(
                _nameOfTeam + ' Team',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            } else
              return CircularProgressIndicator();
          },
        ),
      );
    } else if (_eventObject.type == 'interhall') {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          'Interhall',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      );
    } else if (_eventObject.type == 'hall') {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          'Hall Event',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      );
    } else
      return Text("Wrong Event Type");
  }
}
