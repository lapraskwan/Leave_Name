import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leave_name/models/transaction.dart';

class FinReportScreen extends StatefulWidget {
  @override
  _FinReportScreenState createState() => _FinReportScreenState();
}

class _FinReportScreenState extends State<FinReportScreen> {
  List<Transaction> _transactionList;
  List _debtList;
  double balance;

  Future _fetchFloorTransactions(int floor) async {
    // Fetch the transactions and calculate the balance
    var url = "http://localhost:3000/transaction/getByAttr?attr=floor&value=" +
        floor.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _transactionsJson = json.decode(response.body);
      _transactionList = List<Transaction>(); // Empty the list
      _transactionsJson.forEach((transaction) {
        // Create the list of Transaction
        _transactionList.add(Transaction.fromJson(transaction));
      });
      // Calculate the balance
      balance = _transactionList
          .map((transaction) =>
              transaction.status == 'Completed' ? transaction.amount : 0.0)
          .toList()
          .reduce((a, b) => a + b);
      return balance;
    } else {
      throw Exception("Failed to load transactions.");
    }
  }

  Future _fetchFloorDebts(int floor) async {
    var url =
        "http://localhost:3000/transaction/getAllUsersDebt?attr=floor&value=" +
            floor.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _debtJson = json.decode(response.body);
      _debtList = List(); // Empty the list
      _debtJson.forEach((debt) {
        // Create the list of debts
        _debtList.add(
          {
            'userId': debt['user_id'],
            'floorName': debt['floor_name'],
            'profilePic': debt['profile_pic'],
            'totalDebt': debt['total_debt'],
          },
        );
      });
      return response;
    } else {
      throw Exception("Failed to load user's debts");
    }
  }

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
                    FutureBuilder(
                        future: _fetchFloorTransactions(8),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              NumberFormat.currency(name: 'HKD ')
                                  .format(balance),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          } else
                            return CircularProgressIndicator();
                        }),
                  ],
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: _fetchFloorDebts(8),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _debtList.length,
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
                                  image: AssetImage(
                                      _debtList[index]['profilePic']),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _debtList[index]['floorName'] +
                                ' ' +
                                _debtList[index]['totalDebt'].toString(),
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error);
              } else
                return CircularProgressIndicator();
            },
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
          FutureBuilder(
            future: _fetchFloorTransactions(8),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                        columnSpacing: 40,
                        columns: [
                          
                          DataColumn(
                            label: Text('Title'),
                          ),
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Status'),
                          ),
                          DataColumn(
                            label: Text('Amount'),
                          ),
                        ],
                        rows: _transactionList.map(
                          (Transaction transaction) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(transaction.title),
                                ),
                                DataCell(
                                  Text(transaction.floorName),
                                ),
                                DataCell(
                                  Text(transaction.status),
                                ),
                                DataCell(
                                  Text(transaction.amount.toString()),
                                ),
                              ],
                            );
                          },
                        ).toList()),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error);
              } else
                return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
