class User_model {
  String? id;
  String? email;
  String? password;
  String? uid;
  String? first_name;
  String? last_name;
  String? pseudo;

  User_model({
    this.uid,
    this.email,
    this.password,
  });

  set setUid(value) => uid = value;
}
