import 'package:flutter/material.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_headlines.dart';

class NewsProvider extends ChangeNotifier {
  final GetTopHeadlines getTopHeadlines;

  NewsProvider(this.getTopHeadlines);

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'general';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchHeadlines({
    required String country,
    required String language,
    String? category,
  }) async {
    if (category != null) {
      _selectedCategory = category;
    }
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _articles = await getTopHeadlines(
        category: _selectedCategory,
        country: country,
        language: language,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
