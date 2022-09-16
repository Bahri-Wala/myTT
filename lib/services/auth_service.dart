import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mytt_front/models/add_user.model.dart';
import 'package:mytt_front/models/auth_model.dart';
import 'package:mytt_front/models/sms_model.dart';
import 'package:mytt_front/models/user.dart';
import 'package:mytt_front/screens/home.dart';
import 'package:mytt_front/screens/login.dart';
import 'package:mytt_front/services/dio/PersistantTokenStorage.dart';
import 'package:mytt_front/services/dio/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/error_handling.dart';

class AuthService{
  AuthService._();
  static const url = 'http://192.168.56.1:3000/';

  static dynamic login(phone, password) async {
    try {
      print("logging in...");
      AuthModel user = AuthModel(phone: phone, password: password);
      final response = await http.post(Uri.parse("${url}login"),
          headers: {"content-type": "application/json"},
          body: user.toJson());
      final body = jsonDecode(response.body);
      if (body["error"] != null) {
        return body["error"];
      } else {
        User user = User.fromJson(body["user"]);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", body["access_token"]);
        return user;
      }
    } catch (e) {
      print(e);
    }
  }


  static dynamic register(phone, firstName, lastName, password, confPassword) async {
    try{
      print("signing up...");
      AddUserModel user = AddUserModel(phone: phone, firstName: firstName, lastName: lastName, password: password);
      var response = await http.post(Uri.parse('${url}register'),
        headers: {"content-type": "application/json"},
        body: user.toJson());
      final body = jsonDecode(response.body);
      if (body["error"] != null) {
        return body["error"];
      } else {
        AddUserModel user = AddUserModel.fromJson(response.body);
        return user;
      }
    }catch(e){
      print(e);
    }
  }

  static dynamic sendCode(phone,forgot) async {
    try{
      print("sending code ...");
      var response = await http.post(Uri.parse("${url}send-code"), 
        headers: {"content-type": "application/json"},
        body: json.encode({"phone":phone,"forgot":forgot}));
      final body = jsonDecode(response.body);
      if (body["error"] != null) {
        return body["error"];
      } else {
        SmsModel sms = SmsModel.fromJson(response.body);
        return sms;
      }
    }catch(e){
      print(e);
    }
  }

  static dynamic confirmCode(phone, code) async {
    try{
      print("confirming code");
      SmsModel sms = SmsModel(phone: phone, code: code);
      var response = await http.post(Uri.parse('${url}verify-code'), 
        headers: {"content-type": "application/json"},
        body:sms.toJson());
      final body = jsonDecode(response.body);
      if (body["error"] != null) {
        return body["error"];
      } else {
        SmsModel sms = SmsModel.fromJson(response.body);
        return sms;
      }
    }catch(e){
      print(e);
    }
  }


  static Future<Map<String, String>> getAcessToken(String? refreshToken) async {
    var response = await DioService.dio.post('${DioService.url}refresh-token',
        data: {'refreshToken': refreshToken});
    print("refresh token response = ${response.data}");

    return {'accessToken': response.data['accessToken']};
  }

  static dynamic logout() async {
    print("logging out...");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return "OK";
  }

  static dynamic updatePassword(phone, password, confPassword) async {
    try{
      print("updating password...");
      var response = await http.post(Uri.parse('${url}update-password'),
        headers: {"content-type": "application/json"},
        body: json.encode({"phone":phone,"password":password,"confirmPassword":confPassword}));
      final body = jsonDecode(response.body);
      if (body["error"] != null) {
        return body["error"];
      } else {
        User user = User.fromJson(body);
        return user;
      }
    }catch(e){
      print(e);
    }
  }


}