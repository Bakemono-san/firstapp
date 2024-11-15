class User {
  final bool deleted;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int id;
  final String nom;
  final String prenom;
  final String adresse;
  final String email;
  final String password;
  final String status;
  final String qrCode;
  final String idCardNumber;
  final bool enabled;
  final String telephone;

  User({
    required this.deleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    required this.id,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.email,
    required this.password,
    required this.status,
    required this.qrCode,
    required this.idCardNumber,
    required this.enabled,
    required this.telephone,
  });

  // Factory constructor to create a User from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      deleted: json['deleted'] ?? false,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      adresse: json['adresse'],
      email: json['email'],
      password: json['password'],
      status: json['status'],
      qrCode: json['qrCode'],
      idCardNumber: json['idCardNumber'],
      enabled: json['enabled'] ?? true,
      telephone: json['telephone'],
    );
  }

  // Method to convert a User instance back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'deleted': deleted,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'adresse': adresse,
      'email': email,
      'password': password,
      'status': status,
      'qrCode': qrCode,
      'idCardNumber': idCardNumber,
      'enabled': enabled,
      'telephone': telephone,
    };
  }
}
