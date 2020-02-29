import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leave_name/models/treat.dart';

class TreatScreen extends StatefulWidget {
  @override
  _TreatScreenState createState() => _TreatScreenState();
}

class _TreatScreenState extends State<TreatScreen> {
  List<Treat> _treatList;

  Future _fetchTreats(int floor) async {
    // Fetch the transactions and calculate the balance
    var url = "http://localhost:3000/treat/getByAttr?attr=floor&value=" +
        floor.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var _treatsJson = json.decode(response.body);
      _treatList = List<Treat>(); // Empty the list
      _treatsJson.forEach((treat) {
        // Create the list of Transaction
        _treatList.add(Treat.fromJson(treat));
      });
      return response;
    } else {
      throw Exception("Failed to load transactions.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchTreats(8),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Expanded(
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
                    label: Text('Treat'),
                  ),
                ],
                rows: _treatList.map(
                  (Treat treat) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(treat.datetime.toString().substring(0, 10)),
                        ),
                        DataCell(
                          Text(treat.reason),
                        ),
                        DataCell(
                          Text(treat.name),
                        ),
                        DataCell(
                          Text(treat.quantity.toString()),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
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
