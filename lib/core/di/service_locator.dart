import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../../data/datasources/news_local_datasource.dart';
import '../../data/datasources/news_remote_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/usecases/get_bookmarked_articles.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/search_articles.dart';
import '../../domain/usecases/toggle_bookmark.dart';
import '../../presentation/providers/news_provider.dart';
import '../../presentation/providers/search_provider.dart';
import '../../presentation/providers/bookmarks_provider.dart';
import '../../presentation/providers/settings_provider.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Core
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  // Data Sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTopHeadlines(sl()));
  sl.registerLazySingleton(() => SearchArticles(sl()));
  sl.registerLazySingleton(() => GetBookmarkedArticles(sl()));
  sl.registerLazySingleton(() => ToggleBookmark(sl()));

  // Providers
  sl.registerFactory(() => NewsProvider(sl()));
  sl.registerFactory(() => SearchProvider(sl()));
  sl.registerFactory(
    () => BookmarksProvider(
      getBookmarkedArticles: sl(),
      toggleBookmarkUsecase: sl(),
    ),
  );
  sl.registerLazySingleton(() => SettingsProvider(sl()));
}
