import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/article_dto.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheArticles(List<ArticleDto> articles, String category);
  Future<List<ArticleDto>> getCachedArticles(String category);
  Future<List<ArticleDto>> getBookmarkedArticles();
  Future<void> toggleBookmark(ArticleDto article);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'news_app_v2.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE articles (
            url TEXT PRIMARY KEY,
            title TEXT,
            subTitle TEXT,
            image TEXT,
            author TEXT,
            publishedAt TEXT,
            sourceName TEXT,
            category TEXT,
            isBookmarked INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  @override
  Future<void> cacheArticles(List<ArticleDto> articles, String category) async {
    final db = await database;
    await db.transaction((txn) async {
      // We don't delete bookmarks when caching new headlines
      for (var article in articles) {
        await txn.insert(
          'articles',
          article.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<List<ArticleDto>> getCachedArticles(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'publishedAt DESC',
    );
    return maps.map((map) => ArticleDto.fromMap(map)).toList();
  }

  @override
  Future<List<ArticleDto>> getBookmarkedArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'isBookmarked = 1',
      orderBy: 'publishedAt DESC',
    );
    return maps.map((map) => ArticleDto.fromMap(map)).toList();
  }

  @override
  Future<void> toggleBookmark(ArticleDto article) async {
    final db = await database;
    
    // Check if it exists
    final List<Map<String, dynamic>> existing = await db.query(
      'articles',
      where: 'url = ?',
      whereArgs: [article.url],
    );

    if (existing.isEmpty) {
      // Insert as bookmarked
      final toInsert = article.toMap();
      toInsert['isBookmarked'] = 1;
      await db.insert('articles', toInsert);
    } else {
      // Update its status
      final currentStatus = existing.first['isBookmarked'] as int;
      final newStatus = currentStatus == 1 ? 0 : 1;
      await db.update(
        'articles',
        {'isBookmarked': newStatus},
        where: 'url = ?',
        whereArgs: [article.url],
      );
    }
  }
}
