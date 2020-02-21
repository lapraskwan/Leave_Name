import 'package:flutter/material.dart';

class DrinkSiu {
  DateTime dateTime;
  String title;
  String name;
  String type;

  DrinkSiu({
    this.dateTime,
    this.title,
    this.name,
    this.type,
  });
}

class DrinkSiuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            rows: _drinkSiuList.map(
              (DrinkSiu drinkSiu) {
                return DataRow(cells: [
                  DataCell(
                    Text(drinkSiu.dateTime.toString().substring(0, 10)),
                  ),
                  DataCell(
                    Text(drinkSiu.title),
                  ),
                  DataCell(
                    Text(drinkSiu.name),
                  ),
                  DataCell(
                    Text(drinkSiu.type.toString()),
                  ),
                ]);
              },
            ).toList()),
      ),
    );
  }
}

List<DrinkSiu> _drinkSiuList = [
  DrinkSiu(
      dateTime: DateTime.now(), title: 'Late', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Broke In-Out Board', name: 'Potter', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Siu'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Siu'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
  DrinkSiu(dateTime: DateTime.now(), title: 'Siu', name: 'Op', type: 'Drink'),
];
