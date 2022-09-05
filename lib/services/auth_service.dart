import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mytt_front/models/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:mytt_front/models/user.dart';
import 'package:mytt_front/screens/home.dart';
import 'package:mytt_front/screens/login.dart';
import 'package:mytt_front/services/dio/PersistantTokenStorage.dart';
import 'package:mytt_front/services/dio/dio_service.dart';

import '../constants/error_handling.dart';

class AuthService{
  AuthService._();

  static Future<dynamic> login(phone, password) async {
    try{
      print("logging in");
      AuthModel user = AuthModel(phone: phone, password: password);
      var response = await DioService.dio.post('${DioService.url}login',
        data: user.toJson());
      if (response.data["error"] != null) {
        return response.data["error"];
      } else {
        DioService.setToken(
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token']);
        User user = User.fromJson(response.data["user"]);
        return user;
      }
    } on DioError catch (e) {
      print(e);
    }
  }


  static Future<dynamic> register(phone, name, lastName, password, confPassword) async {
    print("signing up");
    var response = await DioService.dio.post('${DioService.url}register',
        data: {"phone": phone, "firstName":name, "lastName":lastName, "password": password});
    print("register data = ${response.data}");
    return response;
  }

  static Future<dynamic> sendCode(phone) async {
    print("sending code ...");
    var response = await DioService.dio.post("${DioService.url}send-code", data: {"phone":phone});
    print("data = ${response.data}");
    return response;
  }

  static Future<dynamic> confirmCode(phone, code) async {
    print("confirming code");
    print("phone:${phone}, code:${code}");
    var response = await DioService.dio.post('${DioService.url}verify-code', data:{"phone":phone, "code":code});
    print("data= ${response.data}");
    return response;
  }


  
  // void login({required BuildContext context, required String phone, required String password}) async{
  //   try{
  //     AuthModel user = AuthModel(phone: phone, password: password);
  //     var res = await Dio().post(
  //       "$uri/login",
  //       data: user.toJson(),
  //       //headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
  //     );
  //     // log(res.body);
  //     // httpErrorHandle(
  //     //   response: res,
  //     //   context: context,
  //     //   onSuccess: () async {
  //     //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
  //     //     await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
  //     //     Navigator.pushNamedAndRemoveUntil(
  //     //       context,
  //     //       BottomBar.routeName,
  //     //       (route) => false,
  //     //     );
  //     //   },
  //     // );
  //   }catch(e){
  //     log(e.toString());
  //   }

    // List<User> users(){
    //   try{
    //     http.Response res = await http.get(Uri.parse("$uri/user"));
    //     if (res.statusCode == 200) {
    //     // If the call to the server was successful, parse the JSON
    //     List<User> users = new List<User>;
    //     users = json.decode(res.body);
    //     if(users.isNotEmpty){
    //       log("$users.length");
    //     }}else{log("empty list");}
    //   }catch(e){
    //     log(e.toString());
    //   }
    // }


  static Future<Map<String, String>> getAcessToken(String? refreshToken) async {
    var response = await DioService.dio.post('${DioService.url}refresh-token',
        data: {'refreshToken': refreshToken});
    print("refresh token response = ${response.data}");

    return {'accessToken': response.data['accessToken']};
  }

  static Future<dynamic> logout() async {
    try{
      print("logging out");
      var response = await DioService.dio.get('${DioService.url}logout');
      if (response.data["error"] != null) {
        return response.data["error"];
      } else {
        DioService.clearToken();
        return "OK";
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}