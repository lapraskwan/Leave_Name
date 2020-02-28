import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:leave_name/models/event.dart';

String _toCustomDateMonth(DateTime dateTime) {
  return dateTime.day.toString() +
      '/' +
      dateTime.month.toString() +
      ' (' +
      DateFormat.E().format(dateTime) +
      ')';
}

class UpcomingEvents extends StatefulWidget {
  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  List<Event> _upcomingEventList = List<Event>();

  @override
  void initState() {
    super.initState();
  }

  Future _fetchUserEvents(int userId) async {
    var url = "http://localhost:3000/event/getByUser/" + userId.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _userEventJson = json.decode(response.body);
      _upcomingEventList = List<Event>(); // Empty the list
      _userEventJson.forEach((event) {
        // Create the list of Event
        if (event['floor'] != Null) {
          _upcomingEventList.add(FloorEvent.fromJson(event));
        } else if (event['team_id'] != Null) {
          _upcomingEventList.add(TeamEvent.fromJson(event));
        } else if (event['stage'] != Null) {
          // Interhall aquatics and athletics may not have specific opponents
          _upcomingEventList.add(InterhallEvent.fromJson(event));
        } else {
          // Normal hall event
          _upcomingEventList.add(Event.fromJson(event));
        }
      });
      return response;
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserEvents(1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 25, 0),
            child: ListView.builder(
              itemCount: _upcomingEventList.length,
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
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Text(
                                          _upcomingEventList[index].title,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5.0, 0, 0),
                                        child: Text(
                                          _toCustomDateMonth(
                                              _upcomingEventList[index]
                                                  .startTime),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5.0, 0, 0),
                                        child: Text(
                                          DateFormat.Hm().format(
                                                  _upcomingEventList[index]
                                                      .startTime) +
                                              ' @ ' +
                                              _upcomingEventList[index].venue,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5.0, 0, 0),
                                        child: SizedBox(
                                          height: 20,
                                                                                  child: Text(_upcomingEventList[index]
                                              .description),
                                        ),
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
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
