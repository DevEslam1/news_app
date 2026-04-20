class Article {
  final String title;
  final String? subTitle;
  final String? image;
  final String url;
  final String? author;
  final String? publishedAt;
  final String? sourceName;
  final String? category;
  final bool isBookmarked;

  const Article({
    required this.title,
    this.subTitle,
    this.image,
    required this.url,
    this.author,
    this.publishedAt,
    this.sourceName,
    this.category,
    this.isBookmarked = false,
  });

  Article copyWith({
    String? title,
    String? subTitle,
    String? image,
    String? url,
    String? author,
    String? publishedAt,
    String? sourceName,
    String? category,
    bool? isBookmarked,
  }) {
    return Article(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      image: image ?? this.image,
      url: url ?? this.url,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      sourceName: sourceName ?? this.sourceName,
      category: category ?? this.category,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
