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






  // static Future<dynamic> login(phone, password) async {
  //   try{
  //     print("logging in");
  //     AuthModel user = AuthModel(phone: phone, password: password);
  //     var response = await DioService.dio.post('${DioService.url}login',
  //       data: user.toJson());
  //     if (response.data["error"] != null) {
  //       return response.data["error"];
  //     } else {
  //       DioService.setToken(
  //         accessToken: response.data['access_token'],
  //         refreshToken: response.data['refresh_token']);
  //       User user = User.fromJson(response.data["user"]);
  //       return user;
  //     }
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }


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
  // static Future<dynamic> register(phone, name, lastName, password, confPassword) async {
  //   print("signing up");
  //   var response = await DioService.dio.post('${DioService.url}register',
  //       data: {"phone": phone, "firstName":name, "lastName":lastName, "password": password});
  //   print("register data = ${response.data}");
  //   return response;
  // }

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
  // static Future<dynamic> sendCode(phone) async {
  //   try{
  //     print("sending code ...");
  //     var response = await DioService.dio.post("${DioService.url}send-code", data: {"phone":phone});
  //     print("data = ${response.data}");
  //     return response;
  //   }catch(e){
  //     print(e);
  //   }
  // }

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
  // static Future<dynamic> confirmCode(phone, code) async {
  //   print("confirming code");
  //   print("phone:${phone}, code:${code}");
  //   var response = await DioService.dio.post('${DioService.url}verify-code', data:{"phone":phone, "code":code});
  //   print("data= ${response.data}");
  //   return response;
  // }


  static Future<Map<String, String>> getAcessToken(String? refreshToken) async {
    var response = await DioService.dio.post('${DioService.url}refresh-token',
        data: {'refreshToken': refreshToken});
    print("refresh token response = ${response.data}");

    return {'accessToken': response.data['accessToken']};
  }

  static dynamic logout() async {
    // try{
      print("logging out...");
      // final token = prefs.getString("token");
      // print("token!!!!: ${token}");
      //final response = await http.get(Uri.parse('${url}logout'),headers: {"content-type": "application/json", "authorization": "Bearer $token"});
      //final body = jsonDecode(response.body);
      //print("body!!!!: $body");
      // if (body["error"] != null) {
      //   return body["error"];
      // } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        print("token!!!!: ${prefs.getString("token")}");
        return "OK";
      // }
    // }catch (e) {
    //   print(e);
    // }
  }
  // static Future<dynamic> logout() async {
  //   try{
  //     print("logging out");
  //     var response = await DioService.dio.get('${DioService.url}logout');
  //     if (response.data["error"] != null) {
  //       return response.data["error"];
  //     } else {
  //       DioService.clearToken();
  //       return "OK";
  //     }
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }

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