import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leave_name/models/event.dart';

class TeamEventScreen extends StatefulWidget {
  final int teamId;

  TeamEventScreen(this.teamId);

  @override
  _TeamEventScreenState createState() => _TeamEventScreenState();
}

class _TeamEventScreenState extends State<TeamEventScreen> {
  List<TeamEvent> _teamEventList = List<TeamEvent>();

  Future _fetchTeamEvents(int teamId) async {
    var url = "http://localhost:3000/event/getByAttr?attr=team_id&value=" +
        teamId.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _teamEventJson = json.decode(response.body);
      _teamEventList = List<TeamEvent>(); // Empty the list
      _teamEventJson.forEach((event) {
        // Create the list of FloorEvent
        _teamEventList.add(TeamEvent.fromJson(event));
      });
      return response;
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchTeamEvents(widget.teamId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _teamEventList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 40, right: 20, top: 20),
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  // An empty Expanded just for proper layout
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _teamEventList[index].title,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5.0, 0, 0),
                                        child: Text(_toCustomDateMonth(
                                            _teamEventList[index].startTime)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5.0, 0, 0),
                                        child: Text(DateFormat.Hm().format(
                                                _teamEventList[index].startTime) +
                                            ' @ ' +
                                            _teamEventList[index].venue),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5.0, 0, 0),
                                        child:
                                            SizedBox(
                                              height: 20,
                                              child: Text(_teamEventList[index].description)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ButtonBar(
                              buttonPadding:
                                  EdgeInsets.only(right: 20, bottom: 5),
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {},
                                  child: Text('Go!'),
                                ),
                                FlatButton(
                                  onPressed: () {},
                                  child: Text('Next Time...'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 40.0,
                      left: 20.0,
                      width: 100.0,
                      height: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/JunJul.JPG'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else
            return CircularProgressIndicator();
        });
  }
}

String _toCustomDateMonth(DateTime dateTime) {
  return dateTime.day.toString() +
      '/' +
      dateTime.month.toString() +
      ' (' +
      DateFormat.E().format(dateTime) +
      ')';
}