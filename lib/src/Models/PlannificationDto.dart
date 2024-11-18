import 'dart:ffi';

import 'package:firstapp/src/Utils/enums/Period.dart';

class PlannificationDto {
  final double montant;
  final String receiverId;
  final String period;
  final Long? id;

  PlannificationDto({
    required this.montant,
    required this.receiverId,
    required this.period,
    this.id,
  });

  factory PlannificationDto.fromJson(Map<String, dynamic> json) {
    return PlannificationDto(
      montant: json['montant'] as double,
      receiverId: json['receiverId'].toString(),
      period: json['period'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'montant': montant.toString() ,
      'receiver': receiverId,
      'period': period.toString(),
    };
  }
}
