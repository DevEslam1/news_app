import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetBookmarkedArticles {
  final NewsRepository repository;

  GetBookmarkedArticles(this.repository);

  Future<List<Article>> call() async {
    return await repository.getBookmarkedArticles();
  }
}
