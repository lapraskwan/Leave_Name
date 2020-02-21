import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:leave_name/models/team.dart';
import 'package:leave_name/models/user.dart';
import 'package:leave_name/models/event.dart';

class TeamDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Coming Events',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
            iconSize: 30.0,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 20, top: 20),
                    height: 160,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      eventList[index].name,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5.0, 0, 0),
                                      child: Text(_toCustomDateMonth(
                                          eventList[index].startTime)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5.0, 0, 0),
                                      child: Text(DateFormat.Hm().format(
                                              eventList[index].startTime) +
                                          ' @ ' +
                                          eventList[index].venue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5.0, 0, 0),
                                      child: Text(eventList[index].description),
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
        ),
      ],
    );
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

List<Event> eventList = [
  Event(
    name: 'Practice',
    startTime: DateTime(2020, 2, 15, 20, 00),
    venue: 'P2',
    image: 'assets/images/DecJan.JPG',
    description: 'Bring Pad',
  ),
  Event(
    name: 'Dragons B vs HKFC A',
    startTime: DateTime(2020, 2, 17, 18, 00),
    venue: 'HV1',
    image: 'assets/images/FebMar.JPG',
    description: 'How to win...',
  ),
];
