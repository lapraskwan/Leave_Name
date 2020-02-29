import 'package:flutter/material.dart';

import './floormatesScreen.dart';
import './floorEventScreens.dart';
import './finReportScreen.dart';
import './treatScreen.dart';
import './gpaScreen.dart';

class FloorScreen extends StatefulWidget {
  @override
  _FloorScreenState createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen>
    with SingleTickerProviderStateMixin {
  int index;

  List<Widget> screens = [
    FloormatesScreen(),
    FloorEventScreen(),
    FinReportScreen(),
    TreatScreen(),
    GpaScreen(),
  ];

  static const List<String> titles = [
    'Floormates',
    'Upcoming Events',
    'Finacial Report',
    'Treat List',
    'GPA competition',
  ];

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
              iconSize: 30.0,
            ),
            title: Text(
              titles[index],
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              PopupMenuButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  setState(() {
                    index = value;
                  });
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Text(titles[0]),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text(titles[1]),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(titles[2]),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text(titles[3]),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Text(titles[4]),
                  ),
                ],
              )
            ],
          ),
          screens[index],
        ],
      ),
    );
  }
}

// App bar: < Floor
// Functions:
//  Check Floor events (First page), create floor events (Floating action button),
//  Floormates list (information) (End Drawer), Financial report, siu list, collect floor fee, GPA competition

// SizedBox(
//   width: double.infinity,
//   height: 250.0,
//   child: Image(
//     fit: BoxFit.cover,
//     image: AssetImage('assets/images/JunJul.JPG'),
//   ),
// ),
