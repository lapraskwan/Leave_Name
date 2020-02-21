import 'package:flutter/material.dart';
import 'package:leave_name/models/user.dart';

class FloormatesScreen extends StatefulWidget {
  @override
  _FloormatesScreenState createState() => _FloormatesScreenState();
}

class _FloormatesScreenState extends State<FloormatesScreen> {
  int page;
  List<List<User>> floormatesList = [
    _currentList,
    _graduateList,
  ];

  @override
  void initState() {
    super.initState();
    page = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
                color: Colors.white,
                onPressed: () => {
                  setState(() {
                    page = 0;
                  })
                },
                child: Text('Currents'),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(20),
                  ),
                ),
                color: Colors.white,
                onPressed: () => {
                  setState(() {
                    page = 1;
                  })
                },
                child: Text('Graduates'),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) =>
                _floorMatesCard(index),
          ),
        ],
      ),
    );
  }

  Widget _floorMatesCard(int index) {
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
                      image: AssetImage(floormatesList[page][index].proPic),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    floormatesList[page][index].floorName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      children: <Widget>[
                        Text(
                          floormatesList[page][index].curriculum,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            floormatesList[page][index].academicYear.toString(),
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
                      floormatesList[page][index].room,
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

List<User> _currentList = [
  User(
      floorName: 'op',
      floor: 8,
      room: '807',
      hallYear: 3,
      academicYear: 4,
      curriculum: 'BEng(CS)',
      proPic: 'assets/images/AugSep.JPG'),
  User(
      floorName: 'OP',
      floor: 8,
      room: '812A',
      hallYear: 3,
      academicYear: 4,
      curriculum: 'BEng(CS)',
      proPic: 'assets/images/AugSep.JPG'),
];

List<User> _graduateList = [
  User(
      floorName: 'Op',
      floor: 8,
      room: '811A',
      hallYear: 4,
      academicYear: 4,
      curriculum: 'BEng(CS)',
      proPic: 'assets/images/OctNov.JPG'),
  User(
      floorName: 'oP',
      floor: 8,
      room: '801',
      hallYear: 4,
      academicYear: 4,
      curriculum: 'BEng(CS)',
      proPic: 'assets/images/OctNov.JPG'),
];
