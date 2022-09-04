// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';

class Account extends StatefulWidget{
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<String> titles = ["Suivi solde", "Mes informations", "Changer mon mot de passe", "Récupérer PUK", "Gestion des numéros", "Déconnexion"];
  List<Icon> icons = [Icon(Icons.speed,size: 30,color: Colors.blue), Icon(Icons.person_outline,size: 30,color: Colors.blue),  Icon(Icons.lock_outline,size: 30,color: Colors.blue), Icon(Icons.phone_locked_outlined,size: 30,color: Colors.blue), Icon(Icons.phonelink_setup_rounded,size: 30,color: Colors.blue), Icon(Icons.logout,size: 30,color: Colors.blue)];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 226, 248),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:250,bottom: 20),
              child: Center(
                child: InkWell(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: Icon(Icons.close_rounded)
                )
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.61,
              width: double.infinity,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                color: Colors.white
              ),
              child: Column(
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration( 
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage("lib/asset/images/plant_bg.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.account_circle,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Bahri Wala",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "52 37 09 66",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                "Pre -1=11",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left:20,bottom: 15),
                      child: Text(
                        "Mon Compte",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
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
                ],
              ),
            ),
          ]
        )
      ),
      //bottomNavigationBar: BottomNavBar(activeIndex: activeIndex)
    );
  }

  Widget buildList(int index){
    return Container(
      height: 40,
      child: Row(children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 204, 224, 240)
          ),
          child: icons[index]
        ),
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
    );
  }

}

