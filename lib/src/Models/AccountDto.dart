import 'dart:ffi';

import 'package:firstapp/src/Utils/enums/AccountType.dart';

class Accountdto {
  Float solde;
  AccountType type;
  Float plafond;
  Long? id;

  Accountdto(
      {required this.solde,
      required this.type,
      required this.plafond,
      required this.id});

  factory Accountdto.fromJson(Map<String, dynamic> json) {
    return Accountdto(
      solde: json['solde'] as Float,
      type: AccountType.values.byName(json['type'] as String),
      plafond: json['plafond'] as Float,
      id: json['id'] as Long?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'solde': solde,
      'type': type.toString(),
      'plafond': plafond,
      'id': id,
    };
  }
}
