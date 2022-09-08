import 'dart:convert';

class AddUserModel{
  final String phone;
  final String firstName;
  final String lastName;
  final String password;

  AddUserModel({required this.phone, required this.firstName, required this.lastName, required this.password});

  Map<String, dynamic> toMap(){
    return {
      'phone':phone,
      'firstName':firstName,
      'lastName':lastName,
      'password':password,
    };
  }
  
  factory AddUserModel.fromMap(Map<String, dynamic> map){
    return AddUserModel(
      phone:map['phone'] ?? '',
      firstName:map['firstName'] ?? '',
      lastName:map['lastName'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddUserModel.fromJson(String source) => AddUserModel.fromMap(json.decode(source));
}