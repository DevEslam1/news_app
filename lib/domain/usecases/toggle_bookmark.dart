import '../entities/article.dart';
import '../repositories/news_repository.dart';

class ToggleBookmark {
  final NewsRepository repository;

  ToggleBookmark(this.repository);

  Future<void> call(Article article) async {
    return await repository.toggleBookmark(article);
  }
}
