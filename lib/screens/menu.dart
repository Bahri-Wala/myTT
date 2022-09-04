// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<String> titles = ["Internet", "Suivi solde", "Offre Jawek", "Transfer", "Recharge", "Fidèlité Kelmaa", "Services", "Divertissement", "Assistance", "A propos"];
  List<Icon> icons = [Icon(Icons.wifi,size: 30,color: Colors.white),Icon(Icons.speed,size: 30,color: Colors.white), Icon(Icons.emoji_symbols,size: 30,color: Colors.white),  Icon(Icons.transform,size: 30,color: Colors.white), Icon(Icons.payment,size: 30,color: Colors.white), Icon(Icons.favorite_outline,size: 30,color: Colors.white), Icon(Icons.person,size: 30,color: Colors.white),Icon(Icons.sports_esports,size: 30,color: Colors.white), Icon(Icons.help,size: 30,color: Colors.white),Icon(Icons.info,size: 30,color: Colors.white)];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 226, 248),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                image: const DecorationImage(
                  image: AssetImage("lib/asset/images/plant_bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.only(top: 29.0, right: 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: const Image(image: AssetImage('lib/asset/images/logo1.png'))
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Row(
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
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: 45,
                          width: 95,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          
                          child: TextButton(
                            onPressed: (){}, 
                            child: Text(
                              "changer",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            )
                          ),
                        ),
                      )
                    ])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:15),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCard(index*2),
                      buildCard(index*2+1),
                    ],
                  );
                }, 
                separatorBuilder: (context, index){return const SizedBox(height: 15);}, 
                itemCount: (titles.length/2).round()
              ),
            ),
          ]
        )
      ),
      //bottomNavigationBar: BottomNavBar(activeIndex: activeIndex)
    );
  }


  Widget buildCard(int index) {
    return Stack(
      children: [
        Container(
          height: 90,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60), bottomLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
            boxShadow: const [BoxShadow(
                color: Color.fromARGB(255, 151, 207, 252),
                offset: Offset(5.0,5.0),
                blurRadius: 5,
            )],
            color: Colors.white,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                titles[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            )),
        ),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            boxShadow: const [BoxShadow(
                color: Color.fromARGB(255, 214, 214, 214),
                offset: Offset(5.0,5.0),
                blurRadius: 5,
            )],
          ),
          child: icons[index],
        ),
      ],
    );
  }

}

