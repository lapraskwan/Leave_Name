import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leave_name/models/team.dart';
import './teamDetail.dart';

class NotJoinedTeamsScreen extends StatefulWidget {
  @override
  _NotJoinedTeamsScreenState createState() => _NotJoinedTeamsScreenState();
}

class _NotJoinedTeamsScreenState extends State<NotJoinedTeamsScreen> {
  List<Team> _teamList = List<Team>();

  @override
  void initState() {
    super.initState();
  }

  Future _fetchTeamsNotJoinedByUser(int userId) async {
    var url = "http://localhost:3000/team/getTeamsNotJoinedByUser/" +
        userId.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _teamJson = json.decode(response.body);
      _teamList = List<Team>(); // Empty the list
      _teamJson.forEach((team) {
        _teamList.add(Team.fromJSON(team));
      });
      return response;
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchTeamsNotJoinedByUser(1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  'Available Teams',
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
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
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else
          return CircularProgressIndicator();
      },
    );
  }

  Widget _teamCard(BuildContext context, int index) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        child: InkWell(
          onTap: () => _popupDialog(context, _teamList[index].name),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    _teamList[index].emoji,
                    style: TextStyle(fontSize: 70),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _teamList[index].name,
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _popupDialog(BuildContext context, String teamName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text('Do you want to join ' + teamName + ' team?'),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('YES!')),
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('NO!')),
          ],
        );
      },
    );
  }
}
