import 'dart:convert';

class User{
  final String id;
  final String phone;
  final String firstName;
  final String lastName;
  final String password;
  final String token;

  User({required this.id, required this.phone, required this.firstName, required this.lastName, required this.password, required this.token});

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'phone':phone,
      'firstName':firstName,
      'lastName':lastName,
      'password':password,
      'token':token,
    };
  }
  
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id:map['_id'] ?? '',
      phone:map['phone'] ?? '',
      firstName:map['firstName'] ?? '',
      lastName:map['lastName'] ?? '',
      password: map['password'] ?? '',
      token:map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

   factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id:json['_id'] ?? '',
      phone:json['phone'] ?? '',
      firstName:json['firstName'] ?? '',
      lastName:json['lastName'] ?? '',
      password: json['password'] ?? '',
      token:json['token'] ?? '',
    );
  }

  //factory User.fromJson(String source) => User.fromMap(json.decode(source));
}