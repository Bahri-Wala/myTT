import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mytt_front/models/user.dart';
import 'package:mytt_front/services/dio/dio_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  UserService._();
  static const url = 'http://192.168.56.1:3000/';

  static Future<dynamic> getUsers() async {
    try{
      print("gettin users...");
      var response = await DioService.dio.get('${DioService.url}user');
      // if (response.data["error"] != null) {
      //   return response.data["error"];
      // } else {
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      //   User user = User.fromJson(response.data["user"]);
      //   return user;
      // }
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  static dynamic getUser() async {
    try{
      print("fetching user...");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null) {
        final response = await http.get(Uri.parse("${url}user"),
          headers: {"content-type": "application/json", "authorization": "Bearer ${token}"},
        );
        final body = jsonDecode(response.body);
        if (body["error"] != null) {
          return body["error"];
        }else {
          User user = User.fromJson(body);
          return user;
        }
      }else{
        throw new Exception("Token is Expired");
      }
    } catch (e) {
      print(e);
    }
  }
  // static dynamic getUser() async {
  //   try{
  //     print("fetching user...");
  //     var response = await DioService.dio.get("${DioService.url}user/631103776d203954059bd40b");
  //     if (response.data["error"] != null) {
  //       return response.data["error"];
  //     } else {
  //       User user = User.fromJson(response.data);
  //       return user;
  //     }
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }
}