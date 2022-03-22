class UserSchema {
  String? id;
  String? email;
  String? password;
  String? uid;
  String? firstName;
  String? lastName;
  String? pseudo;
  bool? termes;

  UserSchema({
    this.id,
    required this.uid,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.pseudo,
    this.termes = false,
  });

  factory UserSchema.formMap(Map<String, dynamic> data, documentId) {
    String email = data['email'];
    String password = data['password'];
    String uid = data['uid'];
    String firstName = data['firstName'];
    String lastName = data['lastName'];
    String pseudo = data['pseudo'];
    bool termes = data['termes'];

    return UserSchema(
      id: documentId,
      email: email,
      password: password,
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      pseudo: pseudo,
      termes: termes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}
