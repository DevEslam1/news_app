import '../entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    required String category,
    required String country,
    required String language,
  });

  Future<List<Article>> searchArticles({
    required String query,
    required String language,
  });

  Future<List<Article>> getBookmarkedArticles();

  Future<void> toggleBookmark(Article article);
}
