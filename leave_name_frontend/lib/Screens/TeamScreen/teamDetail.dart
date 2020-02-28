import 'package:flutter/material.dart';

import 'package:leave_name/Screens/TeamScreen/teamEventScreen.dart';
import 'package:leave_name/Screens/TeamScreen/teammateScreen.dart';

class TeamDetail extends StatefulWidget {
  final int teamId;

  TeamDetail(this.teamId);

  @override
  _TeamDetailState createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  int _page;
  PageController _pageController;
  List<String> _appBarTitle = [
    'Comming Events',
    'Teammates',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    _page = _pageController.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            _pageController.hasClients
                ? _appBarTitle[_page]
                : _appBarTitle[0],
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
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              TeamEventScreen(widget.teamId),
              TeammatesScreen(widget.teamId),
            ],
            onPageChanged: (int index) {
              setState(() {
                _page = _pageController.page.round();
              });
            },
          ),
        ),
      ],
    );
  }
}
