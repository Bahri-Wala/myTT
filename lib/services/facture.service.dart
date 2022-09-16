import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/facture.model.dart';

class FactureService{
  FactureService._();
  static const url = 'http://192.168.56.1:3000/';

  static Future<dynamic> getFactures() async {
    try{
      print("getting bills...");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null) {
        final response = await http.get(Uri.parse("${url}facture/all"),
          headers: {"content-type": "application/json", "authorization": "Bearer $token"},
        );
        return jsonDecode(response.body);
      }else{
        throw Exception("Token is Expired");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> pay(id) async {
    try{
      print("paying ...");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token != null) {
        final response = await http.patch(Uri.parse("${url}facture/pay/$id"),
          headers: {"content-type": "application/json", "authorization": "Bearer $token"},
        );
        final body = jsonDecode(response.body);
        if (body["error"] != null) {
          return body["error"];
        }else {
          Facture facture = Facture.fromJson(response.body);
          return facture;
        }
      }else{
        throw Exception("Token is Expired");
      }
    }catch(e){
      print(e);
    }
  }

  // static dynamic getUser() async {
  //   try{
  //     print("fetching bill...");
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString("token");
  //     if (token != null) {
  //       final response = await http.get(Uri.parse("${url}user"),
  //         headers: {"content-type": "application/json", "authorization": "Bearer ${token}"},
  //       );
  //       final body = jsonDecode(response.body);
  //       if (body["error"] != null) {
  //         return body["error"];
  //       }else {
  //         User user = User.fromJson(body);
  //         return user;
  //       }
  //     }else{
  //       throw new Exception("Token is Expired");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}