class PaiementDto {
  final String montant;
  final String receiver;

  PaiementDto(
      {
      required this.montant,
      required this.receiver});

  factory PaiementDto.fromJson(Map<String, dynamic> json) {
    return PaiementDto(
      montant: json['montant'].toString(),
      receiver: json['receiver'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'montant': montant,
      'receiver': receiver,
    };
  }
}