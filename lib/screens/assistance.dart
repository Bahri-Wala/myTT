// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';

class Assistance extends StatefulWidget{

  @override
  _AssistanceState createState() => _AssistanceState();
}

class _AssistanceState extends State<Assistance> {
  List<String> titles = ["Renseignement", "Réclamation", "Suggestion", "Historique", "Service client", "Service renseignement"];
  List<Icon> icons = [Icon(Icons.info,size: 30,color: Colors.blue), Icon(Icons.report_problem,size: 30,color: Colors.blue), Icon(Icons.emoji_objects_outlined,size: 30,color: Colors.blue), Icon(Icons.history,size: 30,color: Colors.blue), Icon(Icons.person,size: 30,color: Colors.blue), Icon(Icons.question_mark_rounded,size: 30,color: Colors.blue)];
  int activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 226, 248),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 29.0),
              child: Container(
                width: 100,
                height: 100,
                child: const Image(image: AssetImage('lib/asset/images/logo1.png'))
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Assistance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )
            ),      
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left:20,right: 20),
              itemBuilder: (context, index){return buildList(index);}, 
              separatorBuilder: (context, index){return const SizedBox(height: 10);}, 
              itemCount: titles.length
            ),
          ]
        )
      ),
      //bottomNavigationBar: BottomNavBar(activeIndex: activeIndex)
    );
  }


Widget buildList(int index){
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:15),
        child: Row(children: [
          icons[index],
          Padding(
            padding: const EdgeInsets.only(left:12),
            child: Text(
              titles[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          )
        ]),
      ),
    );
  }
}

