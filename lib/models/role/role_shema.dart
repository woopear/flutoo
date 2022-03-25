class RoleSchema {
  String? libelle;
  String? description;

  RoleSchema({this.libelle, this.description});

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'description': description,
    };
  }
}
