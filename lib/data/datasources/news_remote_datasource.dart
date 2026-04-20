import '../../core/network/dio_client.dart';
import '../models/article_dto.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleDto>> getTopHeadlines({
    required String category,
    required String country,
    required String language,
  });

  Future<List<ArticleDto>> searchArticles({
    required String query,
    required String language,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient dioClient;

  NewsRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ArticleDto>> getTopHeadlines({
    required String category,
    required String country,
    required String language,
  }) async {
    final response = await dioClient.i.get(
      '/top-headlines',
      queryParameters: {
        'category': category,
        'country': country,
        'language': language,
      },
    );

    if (response.data['status'] == 'ok') {
      final List<dynamic> articlesJson = response.data['articles'];
      return articlesJson
          .where((json) => json['title'] != '[Removed]')
          .map((json) => ArticleDto.fromJson(json, category: category))
          .toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch news');
    }
  }

  @override
  Future<List<ArticleDto>> searchArticles({
    required String query,
    required String language,
  }) async {
    final response = await dioClient.i.get(
      '/everything',
      queryParameters: {
        'q': query,
        'language': language,
        'sortBy': 'publishedAt',
      },
    );

    if (response.data['status'] == 'ok') {
      final List<dynamic> articlesJson = response.data['articles'];
      return articlesJson
          .where((json) => json['title'] != '[Removed]')
          .map((json) => ArticleDto.fromJson(json))
          .toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to search news');
    }
  }
}
