// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mytt_front/models/user.dart';
import 'package:mytt_front/screens/account.dart';
import 'package:mytt_front/screens/assistance.dart';
import 'package:mytt_front/screens/baseWidget.dart';
import 'package:mytt_front/screens/home.dart';
import 'package:mytt_front/screens/menu.dart';
import 'package:mytt_front/services/user.service.dart';


class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key, required this.activeIndex}) : super(key: key);
  final int activeIndex;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Future<dynamic> user = UserService.getUser();
  int currentIndex =0;
  bool homeLabel_visibility = true;
  bool infoLabel_visibility = false;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
      homeLabel_visibility = index==0 ? true:false;
      infoLabel_visibility = index==3?false:!homeLabel_visibility;      
    });
  }
  
  final List<Widget> _widgetOptions = <Widget>[Home(),Assistance(),Account(),Menu()];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _widgetOptions.elementAt(currentIndex) ,
      bottomNavigationBar: Container(
        width:size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: BNBCustomPainter(),
            ),
            Center(
              heightFactor: 0.7,
              child: FloatingActionButton(
                elevation: 0.1, 
                onPressed: () {UserService.getUsers();},
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 17, 11, 214), Colors.blue])
                  ),
                  child: Icon(
                    Icons.chat,
                    size: 30,
                  ),
                )
              ),
            ),
            Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:14),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: currentIndex == 0 ? Colors.blue : Colors.grey.shade400,
                            size: 30,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                            // homeLabel_visibility = !homeLabel_visibility;
                            // infoLabel_visibility = false;
                            //Navigator.of(context).pushNamed('/home');
                            //Navigator.push(context, MaterialPageRoute(builder: (_) => BaseWidget(child: Home(),activeIndex: 0)));
                          },
                          splashColor: Colors.white,
                        ),
                        Visibility(
                          visible: homeLabel_visibility,
                          child: Text("Acceuil",style: TextStyle(color: Colors.blue)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:14),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.help,
                            color: currentIndex == 1 ? Colors.blue : Colors.grey.shade400,
                            size: 30,
                          ),
                          onPressed: () {
                            setBottomBarIndex(1);
                          }
                        ),
                        Visibility(
                          visible: infoLabel_visibility,
                          child: Text("Assistance",style: TextStyle(color: Colors.blue)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_box,
                      color: currentIndex == 2 ? Colors.blue : Colors.grey.shade400,
                      size: 30,
                    ),
                    onPressed: () {
                      setBottomBarIndex(currentIndex);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Account()));
                    }
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: currentIndex == 3 ? Colors.blue : Colors.grey.shade400,
                      size: 30,
                    ),
                    onPressed: () {
                      setBottomBarIndex(3);
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}