// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mytt_front/models/user.dart';
import 'package:mytt_front/screens/baseWidget.dart';
import 'package:mytt_front/screens/send_code.dart';
import 'package:mytt_front/screens/test.dart';
import 'package:mytt_front/services/auth_service.dart';
import 'package:mytt_front/services/user.service.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _signInFormKey = GlobalKey<FormState>();
  //final AuthService authService = AuthService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool status = false;
  bool eyeIcon_is_tap = false;
  GlobalKey key = GlobalKey();

 
  @override
  void dispose(){
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }


  void signIn(){
    final data = AuthService.login(context, _phoneController.text, _passwordController.text);
    data.then((value) {
      if ((value is User)) {
        Navigator.push(context,  MaterialPageRoute(builder: (_) => BaseWidget(child:Home(),activeIndex: 0,)));
      } else {
        setState(() {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  "Information",
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 9, 90),
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Text("Login ou mot de passe invalide"),
              ),
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
            )
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
                  "Login",
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
                  "Veuillez entrer ci-dessous vos identifiants",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              )
            ),
            Form(
              key : _signInFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 15, right:15),
                    child: TextFormField(
                      controller: _phoneController,
                      validator: (val){if(val!.isEmpty) {return 'champs obligatoire!';}
                                      return null;},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Votre numéro TT*',
                        hintText: 'Entrez votre numéro de telephone',
                        prefixIcon: Icon(Icons.phone, color: Colors.blue),
                        suffixIcon: IconButton(
                          key: Key("show_info"),
                          icon: Icon(Icons.info, color: Color.fromARGB(255, 201, 201, 201),key: key,), 
                          onPressed: () {
                            setState(() {
                              showMoreText();
                            });
                          }
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 15),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (val){if(val!.isEmpty) {return 'champs obligatoire!';}
                                      return null;},
                      obscureText: !eyeIcon_is_tap,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        labelText: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility, color: eyeIcon_is_tap?Colors.blue:Color.fromARGB(255, 201, 201, 201)), 
                          onPressed: () {
                            setState(() {
                              eyeIcon_is_tap = !eyeIcon_is_tap;
                            });
                          }
                        )
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TextButton(
                          onPressed: (){
                            //TODO FORGOT PASSWORD SCREEN GOES HERE
                          },
                          child: Text(
                            'Mot de passe oublié?',
                            style: TextStyle(
                              color: Colors.blue, 
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 4
                            ),
                          ), 
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Rester connecté",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: FlutterSwitch(
                              activeColor: Color.fromARGB(255, 97, 199, 101),
                              width: 50.0,
                              height: 25,
                              toggleSize: 20.0,
                              value: status,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                setState(() {
                                  status = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                          if(_signInFormKey.currentState!.validate()){
                            try{
                              signIn();
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                            }catch(e){print(e.toString());}
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(
                    color: Color.fromARGB(255, 166, 152, 255),
                    offset: Offset(5.0,5.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                )],
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: const [
                    Color.fromARGB(255, 61, 111, 249),
                    Color.fromARGB(255, 11, 43, 131),
                  ],
                ),
                borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {},
                  //Navigator.push(context, MaterialPageRoute(builder: (_) => Splash(rep)));},
                child: Text(
                  'Mode invité',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 45),
              child: Row(
                children: [
                  Text(
                    "Vous n'avez pas de compte? ",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SendCode()));
                    },
                    child: Text(
                      "Créer un nouveau",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 43, 131),
                        decoration: TextDecoration.underline,
                        decorationThickness: 2
                      ),
                    ),
                  )
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

  void showMoreText() {
    ShowMoreTextPopup popup = ShowMoreTextPopup(context,
        text: "Vous pouvez renseigner votre login créé sur cette application ou sur le portail TT.",
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 18
        ),
        height: 80,
        width: 300,
        backgroundColor: Color.fromARGB(255, 13, 169, 237),
        padding: EdgeInsets.all(4.0),
        borderRadius: BorderRadius.circular(10.0)
    );
    popup.show(
      widgetKey: key,
    );
  }
}