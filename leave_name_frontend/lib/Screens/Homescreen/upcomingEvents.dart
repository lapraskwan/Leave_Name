import 'package:flutter/material.dart';

class UpcomingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 25, 0),
      child: Container(
        height: 500,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 40, right: 20, top: 20),
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Hockey Practice is so fun you know?',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                    child: Text('28/1 (Tue)'),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                    child: Text('10:30 @ Counter 11:30 @ KP'),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                    child: Text('Blue Black Black'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ButtonBar(
                          buttonPadding: EdgeInsets.only(right: 20, bottom: 5),
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              child: Text('Go!'),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text('Next Time...'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 20.0,
                  width: 100.0,
                  height: 100.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/JunJul.JPG'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
