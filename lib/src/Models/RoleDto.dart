class RoleDto {
  final String libelle;

  RoleDto({required this.libelle});

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      libelle: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': libelle,
    };
  }
}