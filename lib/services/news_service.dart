import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/database_helper.dart';

class NewsService {
  final Dio dio;
  final String _apiKey = '0425bdee724449ed9ee81ec6316c2d4f';
  final DatabaseHelper _dbHelper = DatabaseHelper();

  NewsService(this.dio);

  Future<List<ArticleModel>> getTopHeadlines(
      {required String category,
      required String country,
      required String language}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        var articles = await _dbHelper.getArticles(category);
        if (articles.isNotEmpty) {
          return articles;
        } else {
          return []; // Return empty list if no offline data
        }
      }

      var response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$_apiKey&category=$category&language=$language');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromMap(article);
        articlesList.add(articleModel);
      }

      await _dbHelper.insertArticles(articlesList, category);

      return articlesList;
    } catch (e) {
      // If API fails, try to get from DB
      var articles = await _dbHelper.getArticles(category);
      if (articles.isNotEmpty) {
        return articles;
      }
      return []; // Return empty list if no offline data and API failed
    }
  }

  Future<List<ArticleModel>> getNewsBySearch(
      {required String query, required String language}) async {
    try {
      var response = await dio.get(
          'https://newsapi.org/v2/everything?q=$query&apiKey=$_apiKey&language=$language');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromMap(article);
        articlesList.add(articleModel);
      }

      return articlesList;
    } catch (e) {
      return []; // Return empty list on search API failure
    }
  }
}
