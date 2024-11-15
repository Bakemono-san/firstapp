import 'dart:ffi';
import 'package:firstapp/src/Utils/enums/TransactionType.dart';

class TransactionDto {
  final String type;
  final double montant;
  final DateTime date;
  final String? receiverTelephone;
  final String? agentTelephone;
  final String? senderTelephone;
  final int? id;  // Changed from Long? to int? because Dart uses int, not Long
  final bool? annulee;  // Assuming "annulee" is a boolean value based on the response

  TransactionDto({
    required this.type,
    required this.montant,
    required this.date,
    this.receiverTelephone,
    this.agentTelephone,
    this.senderTelephone,
    this.id,
    this.annulee,
  });

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      type: json['type'] as String,
      montant: json['montant'].toDouble(),
      date: DateTime.parse(json['date'] as String),  // Convert string to DateTime
      receiverTelephone: json['receiverTelephone'] as String?,
      agentTelephone: json['agentTelephone'] as String?,
      senderTelephone: json['senderTelephone'] as String?,
      id: json['id'] as int?,  // Changed from Long to int
      annulee: json['annulee'] as bool?,  // Add annulee field handling
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'montant': montant,
      'date': date.toIso8601String(),  // Convert DateTime back to string for JSON
      'receiverTelephone': receiverTelephone,
      'agentTelephone': agentTelephone,
      'senderTelephone': senderTelephone,
      'id': id,
      'annulee': annulee,
    };
  }
}
