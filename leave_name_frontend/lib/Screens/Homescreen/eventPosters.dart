import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventPosters extends StatefulWidget {
  @override
  _EventPostersState createState() => _EventPostersState();
}

class _EventPostersState extends State<EventPosters> {
  PageController _pageController;

  // Move to a model file of eventPosters later.
  List _eventPosters = List<String>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.85,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future _fetchEventPosters() async {
    var url = "http://localhost:3000/event/getByAttr?attr=on_home_page&value=1";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _homeEventJson = json.decode(response.body);
      _eventPosters = List<String>(); // Empty the list
      _homeEventJson.forEach((event) {
        _eventPosters.add(event['poster']);
      });
      return response;
    } else {
      throw Exception("Failed to load users");
    }
  }

  _eventPosterSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value;
        if (index == _pageController.initialPage) {
          value = 1;
        } else {
          value = 0.75;
        }
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.25))
              .clamp(0.0, 1.0); // min value == 0.75, when value.abs() == 1
          // print(value);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: null, // Navigate to the Event Page of this event
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 10.0,
                  ),
                ]),
            child: Center(
              child: Hero(
                tag: _eventPosters[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: AssetImage(_eventPosters[index]),
                    height: 220.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchEventPosters(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 280.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _eventPosters.length,
              itemBuilder: (BuildContext context, int index) =>
                  _eventPosterSelector(index),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
