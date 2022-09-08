import 'dart:convert';

class SmsModel{
  final String phone;
  final String code;

  SmsModel({required this.phone, required this.code});

  Map<String, dynamic> toMap(){
    return {
      'phone':phone,
      'code':code,
    };
  }
  
  factory SmsModel.fromMap(Map<String, dynamic> map){
    return SmsModel(
      phone:map['phone'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SmsModel.fromJson(String source) => SmsModel.fromMap(json.decode(source));
}