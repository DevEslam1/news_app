import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/article_cards/compact_article_tile.dart';
import '../../widgets/common/error_view.dart';
import '../../widgets/common/shimmer_loading.dart';
import '../article_detail/article_detail_screen.dart';

class CategoryFeedScreen extends StatefulWidget {
  final String category;

  const CategoryFeedScreen({super.key, required this.category});

  @override
  State<CategoryFeedScreen> createState() => _CategoryFeedScreenState();
}

class _CategoryFeedScreenState extends State<CategoryFeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCategoryNews();
    });
  }

  void _fetchCategoryNews() {
    final settings = context.read<SettingsProvider>();
    // We can reuse NewsProvider but it might overwrite the home feed state if not handled.
    // For simplicity in this architectural refactor, we'll fetch. 
    // In a production app, we might have a separate CategoryProvider or use a key.
    context.read<NewsProvider>().fetchHeadlines(
          country: settings.country,
          language: settings.language,
          category: widget.category.toLowerCase(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => const CompactArticleShimmer(),
            );
          }

          if (newsProvider.error != null) {
            return ErrorView(
              message: newsProvider.error!,
              onRetry: _fetchCategoryNews,
            );
          }

          return ListView.builder(
            itemCount: newsProvider.articles.length,
            itemBuilder: (context, index) {
              final article = newsProvider.articles[index];
              return CompactArticleTile(
                article: article,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailScreen(article: article),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
