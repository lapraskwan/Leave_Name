import 'package:flutter/cupertino.dart';

class IosBottomNavigation extends StatelessWidget {
  // // To check if the platform if iOS
  // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return Text('000000000000000');
              break;
            case 1:
              return Text('111111111111');
              break;
            case 2:
              return Text('2222222222');
              break;
            case 3:
              return Text('33333333333');
              break;
            default:
              return Text('Default');
              break;
          }
        },
      );
  }
}