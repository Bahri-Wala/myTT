// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mytt_front/models/add_user.model.dart';
import 'package:mytt_front/models/user.dart';
import 'package:mytt_front/screens/confirmation.dart';
import 'package:mytt_front/screens/login.dart';
import 'package:mytt_front/services/auth_service.dart';
import 'package:mytt_front/widgets/error_widget.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';
import 'home.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.phone}) : super(key: key);
  final String phone;
  static const String routeName = "/send-code";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool showText = false;
  bool showText1 = false;
 
  @override
  void dispose(){
    super.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
  }

  void updatePassword() {
    final data = AuthService.updatePassword(widget.phone,_passwordController.text,_confirmPasswordController.text);
    data.then((value) {
      if ((value is User)) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
      } else {
        setState(() {
          showDialog(
            context: context, 
            builder: (context) => ErrorAlert(message: "Erreur d'enregistrement!")
          );
        });
      }
    });
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
                  "Mot de passe oublié",
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
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !showText,
                      validator: (val){if(val!.isEmpty) {return 'Champs obligatoire!';}
                                      return null;},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Mot de passe personnel',
                        hintText: 'Entrez votre mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility, color: showText?Colors.blue:Color.fromARGB(255, 201, 201, 201)), 
                          onPressed: () {
                            setState(() {
                              showText = !showText;
                            });
                          }
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      validator: (val){if(val!.isEmpty) {return 'champs obligatoire!';}
                                      if(val != _passwordController.text){return "Les mots de passes ne sont pas identiques!";}
                                      return null;},
                      obscureText: !showText1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Confirmer mot de passe',
                        hintText: 'Confirmez votre mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility, color: showText1?Colors.blue:Color.fromARGB(255, 201, 201, 201)), 
                          onPressed: () {
                            setState(() {
                              showText1 = !showText1;
                            });
                          }
                        )
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
                          if(_signUpFormKey.currentState!.validate()){
                            updatePassword();
                          }
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
