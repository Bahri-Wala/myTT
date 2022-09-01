import 'package:flutter/material.dart';
import 'package:mytt_front/screens/login.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case Login.routeName: return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => Login()
    );
    default: return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("screen doesn't exist"),
        ),
      )
    );
  }
}