import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_datasource.dart';
import '../datasources/news_remote_datasource.dart';
import '../models/article_dto.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Article>> getTopHeadlines({
    required String category,
    required String country,
    required String language,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.getTopHeadlines(
          category: category,
          country: country,
          language: language,
        );
        await localDataSource.cacheArticles(remoteArticles, category);
        return remoteArticles.map((dto) => dto.toEntity()).toList();
      } catch (e) {
        // Fallback to cache on remote error if connected
        final localArticles = await localDataSource.getCachedArticles(category);
        return localArticles.map((dto) => dto.toEntity()).toList();
      }
    } else {
      final localArticles = await localDataSource.getCachedArticles(category);
      return localArticles.map((dto) => dto.toEntity()).toList();
    }
  }

  @override
  Future<List<Article>> searchArticles({
    required String query,
    required String language,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.searchArticles(
          query: query,
          language: language,
        );
        return remoteArticles.map((dto) => dto.toEntity()).toList();
      } catch (e) {
        throw ServerFailure(e.toString());
      }
    } else {
      throw NetworkFailure('No internet connection');
    }
  }

  @override
  Future<List<Article>> getBookmarkedArticles() async {
    final localArticles = await localDataSource.getBookmarkedArticles();
    return localArticles.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> toggleBookmark(Article article) async {
    final dto = ArticleDto.fromEntity(article);
    await localDataSource.toggleBookmark(dto);
  }
}
