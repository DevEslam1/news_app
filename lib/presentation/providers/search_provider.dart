import 'package:flutter/material.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/search_articles.dart';

class SearchProvider extends ChangeNotifier {
  final SearchArticles searchArticles;

  SearchProvider(this.searchArticles);

  List<Article> _searchResults = [];
  bool _isLoading = false;
  String? _error;
  final List<String> _recentSearches = [];

  List<Article> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get recentSearches => _recentSearches;

  Future<void> performSearch({
    required String query,
    required String language,
  }) async {
    if (query.isEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _searchResults = await searchArticles(
        query: query,
        language: language,
      );
      
      if (!_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _error = null;
    notifyListeners();
  }
}
