class ArticleSchema {
  String? id;
  String? title;

  ArticleSchema({required this.title, this.id});

  factory ArticleSchema.fromMap(Map<String, dynamic> data, String documentId) {
    String? title = data['title'];

    return ArticleSchema(title: title, id: documentId);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}
