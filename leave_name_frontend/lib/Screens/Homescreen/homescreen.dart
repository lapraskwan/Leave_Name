import 'package:flutter/material.dart';
import 'package:leave_name/Screens/Homescreen/eventPosters.dart';
import 'package:leave_name/Screens/Homescreen/upcomingEvents.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // The background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/WLtext.png'),
              ),
            ),
          ),
          // Everything on top of the background image
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                leading: IconButton(
                  padding: EdgeInsets.only(left: 30.0),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                  iconSize: 30.0,
                  color: Colors.black87,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 280,
                  child: EventPosters(),
                ),
              ), // EventPosters
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 500,
                  child: UpcomingEvents(),
                ),
              ), // UpcomingEvents
            ],
          )
        ],
      ),
    );
  }
}
