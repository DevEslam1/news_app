class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String url;

  ArticleModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.url});

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      image: map['urlToImage'],
      title: map['title'] ?? '',
      subTitle: map['description'],
      url: map['url'] ?? '',
    );
  }
}
