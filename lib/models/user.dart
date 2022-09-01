import 'dart:convert';

class User{
  final String id;
  final String phone;
  final String firstName;
  final String lastName;
  final String password;
  final String gender;
  final String active;
  final String token;

  User({required this.id, required this.phone, required this.firstName, required this.lastName, required this.password, required this.gender, required this.active, required this.token});

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'phone':phone,
      'firstName':firstName,
      'lastName':lastName,
      'password':password,
      'gender':gender,
      'active':active,
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
      gender:map['gender'] ?? '',
      active:map['active'] ?? '',
      token:map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}