class ContentArticleSchema {
  String? id;
  String? text;

  ContentArticleSchema({required this.text, this.id});

  factory ContentArticleSchema.formMap(Map<String, dynamic> data, documentId) {
    String? text = data['text'];

    return ContentArticleSchema(text: text, id: documentId);
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }
}
