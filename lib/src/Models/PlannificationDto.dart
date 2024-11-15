import 'dart:ffi';

import 'package:firstapp/src/Utils/enums/Period.dart';

class PlannificationDto {
  final Float montant;
  final String receiverId;
  final Period period;
  final String senderId;
  final Long id;

  PlannificationDto({
    required this.montant,
    required this.receiverId,
    required this.period,
    required this.senderId,
    required this.id,
  });

  factory PlannificationDto.fromJson(Map<String, dynamic> json) {
    return PlannificationDto(
      montant: json['montant'] as Float,
      receiverId: json['receiverId'].toString(),
      period: Period.values.byName(json['period'] as String),
      senderId: json['senderId'].toString(),
      id: json['id'] as Long,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'montant': montant,
      'receiver': receiverId,
      'period': period.toString(),
      'senderId': senderId,
      'id': id,
    };
  }
}
