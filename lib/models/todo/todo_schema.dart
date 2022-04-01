import 'package:cloud_firestore/cloud_firestore.dart';

class TodoSchema {
  String? id;
  String? libelle;
  bool? check;
  String? uid;
  Timestamp? date;

  TodoSchema(
      {this.id,
      required this.libelle,
      this.check = false,
      required this.uid,
      this.date});

  factory TodoSchema.fromMap(Map<String, dynamic> data, String documentId) {
    String libelle = data['libelle'];
    bool check = data['check'];
    String uid = data['uid'];
    Timestamp date = data['date'];

    return TodoSchema(id: documentId, libelle: libelle, check: check, uid: uid, date: date);
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'check': check,
      'uid': uid,
      'date': date,
    };
  }
}
