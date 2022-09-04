// import 'package:flutter/material.dart';

// class Splash extends StatefulWidget {
//   static const String routeName = "/splash-screen";
//   const Splash({Key? key, required this.users}) : super(key: key);
//   final users;
//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Wanderer",
//       theme: ThemeData(),
//       home: body(),
//     );
//   }

//   Widget body() {
//     return ListView(
//       children: new List.generate(widget.users.length, (index) => new ListTile(title: widget.users[index].firstName,)),
//     );
//   }
// }