import 'package:firstapp/src/Utils/enums/TransactionType.dart';

class TransactionSimple {
  final Transactiontype type;
  final double montant;
  final String receiverTelephone;
  final String? agentTelephone;
  final DateTime date;

  TransactionSimple(
      {required this.type,
      required this.montant,
      required this.receiverTelephone,
      this.agentTelephone,
      required this.date});

  factory TransactionSimple.fromJson(Map<String, dynamic> json) {
    return TransactionSimple(
      type: json['type'],
      montant: json['montant'],
      receiverTelephone: json['receiverTelephone'],
      agentTelephone: json['agentTelephone'],
      date: DateTime.parse(json['date']),
    );
  }

  static Map<String, dynamic> toJson(TransactionSimple transaction) {
    return {
      'type': transaction.type,
      'montant': transaction.montant,
      'receiverTelephone': transaction.receiverTelephone,
      'agentTelephone': transaction.agentTelephone,
      'date': transaction.date.toIso8601String(),
    };
  }
}

class TransactionMultiple {
  final double montant;
  final List<String> ids;

  TransactionMultiple({
      required this.montant,
      required this.ids,
     });

  factory TransactionMultiple.fromJson(Map<String, dynamic> json) {
    return TransactionMultiple(
      montant: json['montant'],
      ids: json['ids'],
    );
  }

  static Map<String, dynamic> toJson(TransactionMultiple transaction) {
    return {
      'montant': transaction.montant,
      'ids': transaction.ids,
    };
  }
}