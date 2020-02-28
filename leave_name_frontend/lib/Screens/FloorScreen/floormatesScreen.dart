import 'package:flutter/material.dart';
import 'package:leave_name/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FloormatesScreen extends StatefulWidget {
  @override
  _FloormatesScreenState createState() => _FloormatesScreenState();
}

class _FloormatesScreenState extends State<FloormatesScreen> {
  int _page;
  List _allFloormates = List();
  List<User> _currentFloormates = List<User>();
  List<User> _graduateFloormates = List<User>();

  @override
  void initState() {
    super.initState();
    _page = 0;
  }

  Future _fetchFloormates(int floor) async {
    var url = "http://localhost:3000/user/getByAttr?attr=floor&value=" +
        floor.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      _allFloormates = json.decode(response.body);
      // Empty the Lists
      _currentFloormates = List<User>();
      _graduateFloormates = List<User>();
      // Separate into currents and graduates
      _allFloormates.forEach((user) {
        if (user['graduated'] == 1) {
          _graduateFloormates.add(User.fromJson(user));
        } else {
          _currentFloormates.add(User.fromJson(user));
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
      future: _fetchFloormates(8),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      elevation: _page == 0 ? 0 : 10,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                      color: Colors.white,
                      onPressed: () => {
                        setState(() {
                          _page = 0;
                        })
                      },
                      child: Text('Currents'),
                    ),
                    RaisedButton(
                      elevation: _page == 1 ? 0 : 10,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(20),
                        ),
                      ),
                      color: Colors.white,
                      onPressed: () => {
                        setState(() {
                          _page = 1;
                        })
                      },
                      child: Text('Graduates'),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _page == 0
                      ? _currentFloormates.length
                      : _graduateFloormates.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _floorMatesCard(index, _page),
                ),
              ],
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

  Widget _floorMatesCard(int index, int _page) {
    return Container(
      height: 75,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipOval(
                    child: Image(
                      fit: BoxFit.cover,
                      image: _page == 0
                          ? AssetImage(_currentFloormates[index].profilePic)
                          : AssetImage(_graduateFloormates[index].profilePic),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _page == 0
                        ? _currentFloormates[index].floorName
                        : _graduateFloormates[index].floorName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      children: <Widget>[
                        Text(
                          _page == 0
                              ? _currentFloormates[index].curriculum
                              : _graduateFloormates[index].curriculum,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            _page == 0
                                ? _currentFloormates[index]
                                    .academicYear
                                    .toString()
                                : _graduateFloormates[index]
                                    .academicYear
                                    .toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _page == 0
                          ? _currentFloormates[index].room
                          : _graduateFloormates[index].room,
                      style: TextStyle(fontSize: 36, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
