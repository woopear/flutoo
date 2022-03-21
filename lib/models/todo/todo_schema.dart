class TodoSchema {
  String? id;
  String? libelle;
  bool? check;
  String? uid;

  TodoSchema({this.id, required this.libelle, this.check = false, required this.uid});

  factory TodoSchema.fromMap(Map<String, dynamic> data, String documentId) {
    String libelle = data['libelle'];
    bool check = data['check'];
    String uid = data['uid'];

    return TodoSchema(id: documentId, libelle: libelle, check: check, uid: uid);
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'check': check,
      'uid': uid,
    };
  }
}