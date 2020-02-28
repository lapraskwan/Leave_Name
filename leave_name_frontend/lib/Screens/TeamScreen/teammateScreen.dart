import 'package:flutter/material.dart';
import 'package:leave_name/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeammatesScreen extends StatefulWidget {
  final int teamId;

  TeammatesScreen(this.teamId);

  @override
  _TeammatesScreenState createState() => _TeammatesScreenState();
}

class _TeammatesScreenState extends State<TeammatesScreen> {
  int _page;
  List _allTeammates = List();
  List<User> _currentTeammates = List<User>();
  List<User> _graduateTeammates = List<User>();

  @override
  void initState() {
    super.initState();
    _page = 0;
  }

  Future _fetchTeammates(int teamId) async {
    var url = "http://localhost:3000/team/getUsersInTeam/" +
        teamId.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      _allTeammates = json.decode(response.body);
      // Empty the Lists
      _currentTeammates = List<User>();
      _graduateTeammates = List<User>();
      // Separate into currents and graduates
      _allTeammates.forEach((user) {
        if (user['graduated'] == 1) {
          _graduateTeammates.add(User.fromJson(user));
        } else {
          _currentTeammates.add(User.fromJson(user));
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
      future: _fetchTeammates(widget.teamId),
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
                      ? _currentTeammates.length
                      : _graduateTeammates.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _teamMatesCard(index, _page),
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

  Widget _teamMatesCard(int index, int page) {
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
                      image: page == 0
                          ? AssetImage(_currentTeammates[index].profilePic)
                          : AssetImage(_graduateTeammates[index].profilePic),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    page == 0
                        ? _currentTeammates[index].floorName
                        : _graduateTeammates[index].floorName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      children: <Widget>[
                        Text(
                          page == 0
                              ? _currentTeammates[index].curriculum
                              : _graduateTeammates[index].curriculum,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            page == 0
                                ? _currentTeammates[index]
                                    .academicYear
                                    .toString()
                                : _graduateTeammates[index]
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
                      page == 0
                          ? _currentTeammates[index].room
                          : _graduateTeammates[index].room,
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
