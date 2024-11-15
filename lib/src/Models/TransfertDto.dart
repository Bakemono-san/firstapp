import 'dart:ffi';

class TransfertGroupeDto {
  final Float montant;
  final List<String> ids;

  TransfertGroupeDto({required this.montant,required this.ids});

  factory TransfertGroupeDto.fromJson(Map<String, dynamic> json) {
    return TransfertGroupeDto(
      montant: json['montant'],
      ids: json['ids'] as List<String>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'montant': montant,
      'ids': ids,
    };
  }  
}

