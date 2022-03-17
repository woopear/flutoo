class UserModel {
  String? id;
  String? email;
  String? password;
  String? uid;
  String? firstName;
  String? lastName;
  String? pseudo;
  bool? termes;

  UserModel({
    this.id,
    this.uid,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.pseudo,
    this.termes,
  });

  set setUid(value) => uid = value;
}
