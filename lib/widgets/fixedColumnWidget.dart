// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FixedColumnWidget extends StatelessWidget {
  FixedColumnWidget({required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 10,
      headingRowColor: MaterialStateProperty.all(Colors.pink[300]),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color.fromARGB(255, 189, 188, 188),
            width: 2,
          ),
        ),
      ),
      columns: [
        DataColumn(label: Text('Numéro')),
      ],
      rows: [
        ...data.map((facture) => DataRow(
              cells: [
                DataCell(Text(
                  '${facture["numero"]}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ))
      ],
    );
  }
}
