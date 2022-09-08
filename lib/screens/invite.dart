// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mytt_front/screens/send_code.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/bottom_navBar.dart';

class Invite extends StatefulWidget{
  const Invite({super.key});

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  List<String> titles = ["Achat Forfait", "TT Cash", "E-Facture", "Espace TT", "Assistance"];
  List<Icon> icons = [Icon(Icons.wifi,size: 50,color: Colors.pink[300]),Icon(Icons.attach_money,size: 50,color: Colors.pink[300]), Icon(Icons.description_outlined,size: 50,color: Colors.pink[300]),  Icon(Icons.store_outlined,size: 50,color: Colors.pink[300]), Icon(Icons.question_mark_outlined,size: 50,color: Colors.pink[300])];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:25),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: const Image(image: AssetImage('lib/asset/images/logo1.png'))
                ),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("lib/asset/images/winou_mochkol.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 212, 226, 248)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: RichText(
                      text: TextSpan(
                        text: "Vous n'avez pas de compte sur my\n",
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 9, 90),
                          fontSize: 16
                        ),
                        children: const [
                          TextSpan(
                            text: "MyTT",
                            style: TextStyle(fontWeight: FontWeight.bold)
                          )
                        ]
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      height: 45,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: const [
                            Color.fromARGB(255, 64, 38, 160),
                            Color.fromARGB(255, 13, 9, 90),
                          ],
                        ),
                      ),
                      
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SendCode()));
                        }, 
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        )
                      ),
                    ),
                  )
                ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:15),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  if(titles.length % 2 != 0 && index == (titles.length/2).round()-1){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal:100),
                      child: buildCard(index*2),
                    );
                  }else{
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCard(index*2),
                        buildCard(index*2+1),
                      ],
                    );
                  }
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
    return Container(
      height: 110,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromARGB(255, 196, 196, 196))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icons[index],
          Text(
            titles[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ],
      ),
    );
  }

}

