import 'package:news_app/models/article_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'news.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE articles(
        url TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        subTitle TEXT,
        image TEXT,
        category TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertArticles(List<ArticleModel> articles, String category) async {
    final db = await database;
    Batch batch = db.batch();
    for (var article in articles) {
      batch.insert(
        'articles',
        article.toMap(category: category),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  Future<List<ArticleModel>> getArticles(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) {
      return ArticleModel.fromMap(maps[i]);
    });
  }
}
