import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import 'package:leave_name/Screens/TeamScreen/teamEventScreen.dart';
import 'package:leave_name/Screens/TeamScreen/teammateScreen.dart';

class TeamDetail extends StatefulWidget {
  final int teamId;

  TeamDetail(this.teamId);

  @override
  _TeamDetailState createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  ValueNotifier<int> _page = ValueNotifier<int>(0);
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
    // _page.value = _pageController.initialPage;
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
                ? _appBarTitle[_page.value]
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
                _page.value = index;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: CirclePageIndicator(
            itemCount: _appBarTitle.length,
            currentPageNotifier: _page,
          ),
        ),
      ],
    );
  }
}
