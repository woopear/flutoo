import 'package:flutoo/models/role/role_shema.dart';

class UserSchema {
  String? id;
  String? email;
  String? password;
  String? uid;
  String? firstName;
  String? lastName;
  String? pseudo;
  bool? termes;
  String? avatar;
  Map<String, dynamic>? role;

  UserSchema({
    this.id,
    required this.uid,
    required this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.pseudo,
    this.termes = false,
    this.avatar,
    required this.role,
  });

  factory UserSchema.formMap(Map<String, dynamic> data, documentId) {
    String email = data['email'];
    String uid = data['uid'];
    String firstName = data['firstName'] ?? "";
    String lastName = data['lastName'] ?? "";
    String pseudo = data['pseudo'] ?? "";
    bool termes = data['termes'] ?? false;
    String avatar = data['avatar'] ?? "";
    Map<String, dynamic> role = RoleSchema(
      libelle: data['role']['libelle'],
      description: data['role']['description'],
    ).toMap();

    return UserSchema(
      id: documentId,
      email: email,
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      pseudo: pseudo,
      termes: termes,
      avatar: avatar,
      role: role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'firstName': firstName ?? '',
      'lastName': lastName ?? '',
      'pseudo': pseudo ?? '',
      'termes': termes ?? false,
      'avatar': avatar ?? '',
      'role': role,
    };
  }
}
