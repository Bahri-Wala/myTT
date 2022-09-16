import 'dart:convert';
import 'dart:ffi';

class Facture{
  final String id;
  final String numero;
  final String montant;
  final bool payement;
  final String type;

  Facture({required this.id, required this.numero, required this.montant, required this.payement, required this.type});

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'numero':numero,
      'montant':montant,
      'payement':payement,
      'type':type,
    };
  }
  
  factory Facture.fromMap(Map<String, dynamic> map){
    return Facture(
      id:map['_id'] ?? '',
      numero:map['numero'] ?? '',
      montant:map['montant'] ?? '',
      payement:map['payement'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  //  factory Facture.fromJson(Map<dynamic, dynamic> json) {
  //   return Facture(
  //     id:json['_id'] ?? '',
  //     numero:json['numero'] ?? '',
  //     montant:json['montant'] ?? '',
  //     payement:json['payement'] ?? '',
  //     type: json['type'] ?? '',
  //   );
  // }

  factory Facture.fromJson(String source) => Facture.fromMap(json.decode(source));
}