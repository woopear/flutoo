import 'package:cloud_firestore/cloud_firestore.dart';

class ConditionSchema {
  String? id;
  String? title;
  bool? activate;
  Timestamp? date;

  ConditionSchema(
      {this.id, required this.title, this.activate = false, this.date});

  factory ConditionSchema.formMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    bool activate = data['activate'];
    Timestamp date = data['date'];

    return ConditionSchema(
        id: documentId, title: title, activate: activate, date: date);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'activate': activate,
      'date': date,
    };
  }
}
