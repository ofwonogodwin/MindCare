class Article {
  const Article({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.content,
    required this.readTime,
  });

  final int id;
  final String title;
  final String category;
  final String summary;
  final String content;
  final int readTime;
}
