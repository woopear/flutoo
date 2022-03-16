class User_model {
  String? email;
  String? password;
  String? uid;

  User_model({
    this.uid,
    this.email,
    this.password,
  });

  set setUid(value) => uid = value;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'password': password,
      };
}
