// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    Key? key,required this.message
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      title: Text(
        "Information",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromARGB(255, 13, 9, 90),
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
      ),
      content: Text(message,textAlign: TextAlign.center),
      actions: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom:15),
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(
                  color: Color.fromARGB(255, 252, 114, 160),
                  offset: Offset(5.0,5.0),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                )],
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: const [
                    Color.fromARGB(255, 212, 187, 206),
                    Color.fromARGB(255, 216, 43, 106),
                  ],
                ),
                borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}