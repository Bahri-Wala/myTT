// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mytt_front/screens/confirmation.dart';
import 'package:mytt_front/services/auth_service.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';
import 'home.dart';

class Register extends StatefulWidget {
  static const String routeName = "/send-code";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _signUpFormKey = GlobalKey<FormState>();
  //final AuthService authService = AuthService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool status = false;
  bool eyeIcon_is_tap = false;
  GlobalKey key = GlobalKey();
  bool policy_check = false;

 
  @override
  void dispose(){
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }


  void signUp(){
    AuthService.register(_phoneController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0,left: 10.0),
                child: Container(
                    width: 150,
                    height: 150,
                    child: Image(image: AssetImage('lib/asset/images/logo.png'))),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Inscription",
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 9, 90),
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ),      
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Veuillez saisir les informations ci-dessous",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              )
            ),
            Form(
              key : _signUpFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 175,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            labelText: 'Nom',
                            hintText: 'Entrez votre nom',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            labelText: 'Prénom',
                            hintText: 'Entrez votre prénom',
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Mot de passe",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, right:15),
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Mot de passe personnel',
                        hintText: 'Entrez votre mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Confirmer mot de passe',
                        hintText: 'Confirmez votre mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:25),
                    child: Container(
                      height: 50,
                      width: 350,
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
                          //if(_signInFormKey.currentState!.validate()){
                            //signUp();
                          //}
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                        },
                        child: Text(
                          'Valider',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 400,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("lib/asset/images/bg.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

