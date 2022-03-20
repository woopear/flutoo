import 'package:cloud_firestore/cloud_firestore.dart';

class ConditionSchema {
  String? id;
  String? title;
  Timestamp? date = Timestamp.now();
  bool? activate;

  ConditionSchema({
    this.id,
    required this.title,
    this.date,
    this.activate = false,
  });

  factory ConditionSchema.fromMap(Map<String, dynamic> data, String documentId) {
    String title = data['title'];
    bool activate = data['activate'];
    Timestamp date = data['date'];

    return ConditionSchema(id: documentId, title: title, activate: activate, date: date);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'activate': activate,
    };
  }
}
