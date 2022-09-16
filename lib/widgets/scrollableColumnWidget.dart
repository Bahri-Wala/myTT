// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytt_front/models/facture.model.dart';
import 'package:mytt_front/screens/factures.dart';
import 'package:mytt_front/services/facture.service.dart';
import 'package:mytt_front/widgets/error_widget.dart';

class ScrollableColumnWidget extends StatefulWidget {
  const ScrollableColumnWidget({super.key, required this.data});
  final data;

  @override
  _ScrollableColumnWidgetState createState() => _ScrollableColumnWidgetState();
}

class _ScrollableColumnWidgetState extends State<ScrollableColumnWidget>{

  void pay(id){
    final data = FactureService.pay(id);
    data.then((value) {
      if ((value is Facture)) {
        setState(() {
          showDialog(
            context: context, 
            builder: (context) => ErrorAlert(message: "Service de payement en ligne")
          );
        });
      } else {
        setState(() {
          showDialog(
            context: context, 
            builder: (context) => ErrorAlert(message: "Une erreur est survenue!")
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.pink[100]),
            columnSpacing: 40,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Montant')),
              DataColumn(label: Text('Payement')),
              DataColumn(label: Text(""))
            ],
            rows: [
              ...widget.data
                  .map((facture) => DataRow(
                        cells: [
                          DataCell(
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                DateFormat.yMMMd().format(DateTime.parse(facture["createdAt"])).toString()))),
                          DataCell(
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Text('${facture["montant"].toString()} Dt'))),
                          DataCell(
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: facture["payement"]?Icon(Icons.task_alt_outlined,color: Colors.green):Icon(Icons.close,color: Colors.red))),
                          DataCell(facture["payement"]?Container():
                            Container(
                              height: 40,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: const [
                                      Color.fromARGB(255, 194, 14, 65),
                                      Color.fromARGB(255, 251, 119, 220),
                                    ],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  pay(facture["_id"]);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => Factures()));
                                },
                                child: Text(
                                  "Payer",
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              )
                            ), 
                          )
                        ],
                      ))
            ]),
      ),
    );
  }
}
