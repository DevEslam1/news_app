import '../entities/article.dart';
import '../repositories/news_repository.dart';

class SearchArticles {
  final NewsRepository repository;

  SearchArticles(this.repository);

  Future<List<Article>> call({
    required String query,
    required String language,
  }) async {
    return await repository.searchArticles(
      query: query,
      language: language,
    );
  }
}
