import 'package:flutter/material.dart';

class GpaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Op Team!!!',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'op Team...',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              DataTable(
                columns: [
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('GPA'),
                  ),
                ],
                rows: [
                  DataRow(cells: [DataCell(Text('Op')), DataCell(Text('4.3'))]),
                ],
              ),
              VerticalDivider(),
              DataTable(
                columns: [
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('GPA'),
                  ),
                ],
                rows: [
                  DataRow(cells: [DataCell(Text('op')), DataCell(Text('4.3'))]),
                ],
              ),
            ],
          ),
          Text('Obviously, the winner is... OP!!!!!!!!!!!!!!!!', style: TextStyle(fontSize: 60))
        ],
      ),
    );
  }
}
