import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:leave_name/models/user.dart';

class Transaction {
  DateTime dateTime;
  String title;
  String name;
  double amount;

  Transaction({
    this.dateTime,
    this.title,
    this.name,
    this.amount,
  });
}

class FinReportScreen extends StatelessWidget {
  final double balance = _transactionList
      .map((transaction) => transaction.amount)
      .toList()
      .reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/header.jpg'),
                ),
              ),
              Positioned(
                right: 10,
                top: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      NumberFormat.currency(name: 'HKD ').format(balance),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _currentList.length,
              itemBuilder: (BuildContext context, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: SizedBox(
                        height: 75,
                        width: 75,
                        child: ClipOval(
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(_currentList[index].profilePic),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _currentList[index].floorName + ' -600.0',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: Text(
              'Transactions',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                  columnSpacing: 40,
                  columns: [
                    DataColumn(
                      label: Text('Date'),
                    ),
                    DataColumn(
                      label: Text('Title'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Amount'),
                    ),
                  ],
                  rows: _transactionList.map(
                    (Transaction transaction) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                              transaction.dateTime.toString().substring(0, 10)),
                        ),
                        DataCell(
                          Text(transaction.title),
                        ),
                        DataCell(
                          Text(transaction.name),
                        ),
                        DataCell(
                          Text(transaction.amount.toString()),
                        ),
                      ]);
                    },
                  ).toList()),
            ),
          ),
        ],
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
      profilePic: 'assets/images/AugSep.JPG'),
  User(
      floorName: 'OP',
      floor: 8,
      room: '812A',
      hallYear: 3,
      academicYear: 4,
      curriculum: 'BEng(CS)',
      profilePic: 'assets/images/AugSep.JPG'),
];

List<Transaction> _transactionList = [
  Transaction(
      dateTime: DateTime.now(), title: 'Floor fee', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: -888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: -888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
  Transaction(dateTime: DateTime.now(), title: 'Siu', name: 'Op', amount: 888),
];
