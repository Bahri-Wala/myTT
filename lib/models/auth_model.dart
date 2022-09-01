import 'dart:convert';

class AuthModel{
  final String phone;
  final String password;

  AuthModel({required this.phone, required this.password});

  Map<String, dynamic> toMap(){
    return {
      'phone':phone,
      'password':password,
    };
  }
  
  factory AuthModel.fromMap(Map<String, dynamic> map){
    return AuthModel(
      phone:map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source));
}