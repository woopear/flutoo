class ArticleSchema {
  String? id;
  String? title;

  ArticleSchema({
    this.id,
    required this.title,
  });

  factory ArticleSchema.fromMap(Map<String, dynamic> data, String documentId) {
    String title = data['title'];

    return ArticleSchema(id: documentId, title: title);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}
