// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mytt_front/models/facture.model.dart';
import 'package:mytt_front/services/facture.service.dart';
import 'package:mytt_front/widgets/fixedColumnWidget.dart';
import 'package:mytt_front/widgets/scrollableColumnWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';

class Factures extends StatefulWidget{
  Future<dynamic> factures = FactureService.getFactures();

  @override
  _FacturesState createState() => _FacturesState();
}

class _FacturesState extends State<Factures> {
  List<String> titles = ["createdAt", "montant", "payement"];
  List table_titles = [{"numero":"Numéro","createdAt":"Date", "montant":"Montant", "payement":"Payement"}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 226, 248),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top:30, left: 5),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blue,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ),
            Container(
              width: 100,
              height: 100,
              child: const Image(image: AssetImage('lib/asset/images/logo1.png'))
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Factures",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )
            ), 

            FutureBuilder(
              future: widget.factures,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Row(
                    children: [
                      FixedColumnWidget(data:snapshot.data),
                      ScrollableColumnWidget(data:snapshot.data),
                    ],
                  );
                }else{
                  return Text("Loading...");
                }
              }
            ),
          ]
        )
      ),
    );
  }

}

