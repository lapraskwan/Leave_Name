import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './Screens/Homescreen/homescreen.dart';
import './Screens/FloorScreen/floorScreen.dart';
import './Screens/TeamScreen/myTeamsScreen.dart';

// Define the drawer item
class DrawerItem {
  String emoji;
  String title;
  Function action;
  DrawerItem({this.emoji, this.title, this.action});
}

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentTabIndex = 0;

  final _homeScreenKey = GlobalKey<NavigatorState>();
  // final _calendarScreenKey = GlobalKey<NavigatorState>();
  // final _chatScreenKey = GlobalKey<NavigatorState>();
  // final _settingsScreenKey = GlobalKey<NavigatorState>();

  void _onTapped(int index, BuildContext context) {
    if (_currentTabIndex == index) {
      switch (index) {
        case 0:
          _homeScreenKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 1:
          // _calendarScreenKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 2:
          // _chatScreenKey.currentState.popUntil((route) => route.isFirst);
          break;
        case 3:
          // _settingsScreenKey.currentState.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentTabIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: SafeArea(
      //   child: tabs[_currentTabIndex],
      // ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentTabIndex,
          children: <Widget>[
            Navigator(
              key: _homeScreenKey,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => Homescreen(),
              ),
            ),
            Text('Calendar Tab'),
            Text('Chat Tab'),
            Text('Settings Tab'),
            // Navigator(
            //   key: _calendarScreenKey,
            //   onGenerateRoute: (route) => MaterialPageRoute(
            //     settings: route,
            //     builder: (context) => Text('Calendar Tab'),
            //   ),
            // ),
            // Navigator(
            //   key: _chatScreenKey,
            //   onGenerateRoute: (route) => MaterialPageRoute(
            //     settings: route,
            //     builder: (context) => Text('Chat Tab'),
            //   ),
            // ),
            // Navigator(
            //   key: _settingsScreenKey,
            //   onGenerateRoute: (route) => MaterialPageRoute(
            //     settings: route,
            //     builder: (context) => Text('Setting Tab'),
            //   ),
            // ),
          ],
        ),
      ),
      drawer: _myDrawer(context, _homeScreenKey), // Defined below in this file
      drawerEdgeDragWidth:
          0.0, // To ensure drawer cannot be opened by edge swiping
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTabIndex,
        onTap: (index) => _onTapped(index, context),
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Setting'),
          ),
        ],
      ),
    );
  }

  Widget _myDrawer(BuildContext context, GlobalKey<NavigatorState> key) {
    return Drawer(
      child: Column(children: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _customDrawerHeader(),
              ..._customListTiles(context, key),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            onTap: () {},
          ),
        ),
      ]),
    );
  }

  List<Widget> _customListTiles(
      BuildContext context, GlobalKey<NavigatorState> key) {
    List<Widget> list = <Widget>[];
    drawerItemsList.forEach((item) {
      list.add(_customListTile(context, key, item));
    });
    return list;
  }

  Widget _customListTile(
      BuildContext context, GlobalKey<NavigatorState> key, DrawerItem item) {
    return Container(
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: Container(
          height: 40.0,
          width: 40.0,
          child: Center(
            child: Text(
              item.emoji,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        onTap: () => item.action(context, key),
      ),
    );
  }

  Widget _customDrawerHeader() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 90.0,
              width: 90.0,
              child: ClipOval(
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/JunJul.JPG'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10.0, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'OP @ Rapport',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A list to store all drawer items data, so that it can be better organised
  List<DrawerItem> drawerItemsList = [
    DrawerItem(
      emoji: '🏬',
      title: 'Floor',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => FloorScreen(),
          ),
        );
        Navigator.pop(context);
      },
    ),
    DrawerItem(
      emoji: '🎾',
      title: 'Teams',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => MyTeamsScreen(),
          ),
        );
        Navigator.pop(context);
      },
    ),
    DrawerItem(
      emoji: '🏆',
      title: 'Interhall',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => FloorScreen(),
          ),
        );
        Navigator.pop(context);
      },
    ),
    DrawerItem(
      emoji: '📚',
      title: 'Academic',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => FloorScreen(),
          ),
        );
      },
    ),
    DrawerItem(
      emoji: '🙋‍♂️',
      title: 'Let\'s Vote!',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => FloorScreen(),
          ),
        );
        Navigator.pop(context);
      },
    ),
    DrawerItem(
      emoji: '🀄️',
      title: 'MJ',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => FloorScreen(),
          ),
        );
        Navigator.pop(context);
      },
    ),
    DrawerItem(
      emoji: '🍨',
      title: 'Call Siu',
      action: (BuildContext context, GlobalKey<NavigatorState> key) {
        key.currentState.push(
          MaterialPageRoute(
            builder: (context) => FloorScreen(),
          ),
        );
        Navigator.pop(context);
      },
    ),
  ];

}
