// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> titles = ["Suivi solde", "Bon Plan", "Internet", "Recharge", "Mon programme Kelma", "E-Facture"];
  List<Icon> icons = [Icon(Icons.speed,size: 30,color: Colors.blue), Icon(Icons.card_giftcard,size: 30,color: Colors.blue), Icon(Icons.wifi,size: 30,color: Colors.blue), Icon(Icons.payment,size: 30,color: Colors.blue), Icon(Icons.favorite,size: 30,color: Colors.blue), Icon(Icons.description_outlined,size: 30,color: Colors.blue)];
  List<String> pubs = ["winou_mochkol", "hadranet", "waffi", "wa_rap"];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 226, 248),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 290.0,
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
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Bienvenue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ),      
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 5),
                      child: Text(
                        "Bahri Wala",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration( 
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.3)
                      ),
                      child: Row(
                        children: <Widget> [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 5),
                            child: Icon(
                              Icons.phone_android,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                          Padding(
                            padding: const EdgeInsets.only(left: 140),
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
                          )
                        ]),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index){return buildCard(index);}, 
                separatorBuilder: (context, index){return const SizedBox(width: 10);}, 
                itemCount: 2
              ),
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
            Padding(
              padding: const EdgeInsets.only(bottom:10, top:15),
              child: CarouselSlider.builder(
                itemCount: pubs.length, 
                itemBuilder: (context, index, realIndex){return buildPub(index);}, 
                options: CarouselOptions(
                  height:200,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) => setState(() => activeIndex = index)
                )
              ),
            ),
          ]
        )
      ),
      //bottomNavigationBar: BottomNavBar(activeIndex: activeIndex)
    );
  }


  Widget buildCard(int index) {
    Icon icon; 
    String title;
    String amount;
    String date;
    String button;
    if(index == 0){
      icon = Icon(Icons.attach_money,size: 30,color: Colors.blue); 
      title = "Votre Solde";
      amount = "2.550 DT";
      date= "Valable au 13-12-2022";
      button = "Recharger";
    }else{
      icon = Icon(Icons.four_g_mobiledata,size: 30,color: Colors.blue); 
      title = "Forfait Internet Mobile";
      amount = "500 Mo";
      date= "Valable au 08-08-2022";
      button = "Acheter";
    }
    return Container(
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                icon,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 115, 115, 115)
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        color: Color.fromARGB(255, 42, 33, 204),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
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
                        Color.fromARGB(255, 243, 133, 92),
                      ],
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    button,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ), 
            ]
          ),
        ],
      ),
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


  Widget buildPub(int index){
    return Container(
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage("lib/asset/images/${pubs[index]}.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: buildIndicator(),
            )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child: Center(
                  child: Text(
                    "${index+1}/${pubs.length}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  )
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex, 
    count: pubs.length,
    effect: ExpandingDotsEffect(dotColor: Colors.grey, activeDotColor: Colors.white,dotHeight: 8, dotWidth: 8),
    
  );
}

