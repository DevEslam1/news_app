import '../../domain/entities/article.dart';

class ArticleDto {
  final String title;
  final String? description;
  final String? urlToImage;
  final String url;
  final String? author;
  final String? publishedAt;
  final String? sourceName;
  final String? category;
  final int isBookmarked; // 0 for false, 1 for true (SQLite compatible)

  ArticleDto({
    required this.title,
    this.description,
    this.urlToImage,
    required this.url,
    this.author,
    this.publishedAt,
    this.sourceName,
    this.category,
    this.isBookmarked = 0,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json, {String? category}) {
    return ArticleDto(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'] ?? '',
      author: json['author'],
      publishedAt: json['publishedAt'],
      sourceName: json['source'] != null ? json['source']['name'] : null,
      category: category,
      isBookmarked: 0,
    );
  }

  factory ArticleDto.fromMap(Map<String, dynamic> map) {
    return ArticleDto(
      title: map['title'],
      description: map['subTitle'],
      urlToImage: map['image'],
      url: map['url'],
      author: map['author'],
      publishedAt: map['publishedAt'],
      sourceName: map['sourceName'],
      category: map['category'],
      isBookmarked: map['isBookmarked'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': description,
      'image': urlToImage,
      'url': url,
      'author': author,
      'publishedAt': publishedAt,
      'sourceName': sourceName,
      'category': category,
      'isBookmarked': isBookmarked,
    };
  }

  Article toEntity() {
    return Article(
      title: title,
      subTitle: description,
      image: urlToImage,
      url: url,
      author: author,
      publishedAt: publishedAt,
      sourceName: sourceName,
      category: category,
      isBookmarked: isBookmarked == 1,
    );
  }

  factory ArticleDto.fromEntity(Article entity) {
    return ArticleDto(
      title: entity.title,
      description: entity.subTitle,
      urlToImage: entity.image,
      url: entity.url,
      author: entity.author,
      publishedAt: entity.publishedAt,
      sourceName: entity.sourceName,
      category: entity.category,
      isBookmarked: entity.isBookmarked ? 1 : 0,
    );
  }
}
