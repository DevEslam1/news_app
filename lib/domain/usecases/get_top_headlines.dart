import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  Future<List<Article>> call({
    required String category,
    required String country,
    required String language,
  }) async {
    return await repository.getTopHeadlines(
      category: category,
      country: country,
      language: language,
    );
  }
}
