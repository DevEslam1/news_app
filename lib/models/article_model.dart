class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String url;
  final String? category;

  ArticleModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.url,
      this.category});

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      image: map['image'] ?? map['urlToImage'],
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? map['description'],
      url: map['url'] ?? '',
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap({String? category}) {
    return {
      'image': image,
      'title': title,
      'subTitle': subTitle,
      'url': url,
      'category': category ?? this.category,
    };
  }
}
