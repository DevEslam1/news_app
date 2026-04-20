import 'package:flutter/material.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_bookmarked_articles.dart';
import '../../domain/usecases/toggle_bookmark.dart';

class BookmarksProvider extends ChangeNotifier {
  final GetBookmarkedArticles getBookmarkedArticles;
  final ToggleBookmark toggleBookmarkUsecase;

  BookmarksProvider({
    required this.getBookmarkedArticles,
    required this.toggleBookmarkUsecase,
  });

  List<Article> _bookmarkedArticles = [];
  bool _isLoading = false;

  List<Article> get bookmarkedArticles => _bookmarkedArticles;
  bool get isLoading => _isLoading;

  Future<void> fetchBookmarks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _bookmarkedArticles = await getBookmarkedArticles();
    } catch (_) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(Article article) async {
    await toggleBookmarkUsecase(article);
    await fetchBookmarks(); // Refresh list
  }
  
  bool isBookmarked(String url) {
    return _bookmarkedArticles.any((article) => article.url == url);
  }
}
