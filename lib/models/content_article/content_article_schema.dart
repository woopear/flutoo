class ContentArticleSchema {
  String? id;
  String? text;

  ContentArticleSchema({this.id, required this.text});

  factory ContentArticleSchema.fromMap(Map<String, dynamic> data, documentId) {
    String text = data['text'];

    return ContentArticleSchema(id: documentId, text: text);
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }
}
