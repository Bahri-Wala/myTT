import 'package:flutter/material.dart';
import 'package:mytt_front/widgets/bottom_navBar.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  final int activeIndex;
  const BaseWidget({required this.child, required this.activeIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: child),
          BottomNavBar(activeIndex: activeIndex),
        ],
      ),
    );
  }
}