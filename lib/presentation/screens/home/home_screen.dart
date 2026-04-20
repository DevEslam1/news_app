import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/article_cards/compact_article_tile.dart';
import '../../widgets/article_cards/featured_article_card.dart';
import '../../widgets/common/category_chip.dart';
import '../../widgets/common/error_view.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/shimmer_loading.dart';
import '../article_detail/article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNews();
    });
  }

  void _fetchNews() {
    final settings = context.read<SettingsProvider>();
    context.read<NewsProvider>().fetchHeadlines(
          country: settings.country,
          language: settings.language,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app_icon.png',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              'NEWSCLOUD',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => _fetchNews(),
        child: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            if (newsProvider.isLoading && newsProvider.articles.isEmpty) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: FeaturedArticleShimmer()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const CompactArticleShimmer(),
                      childCount: 5,
                    ),
                  ),
                ],
              );
            }

            if (newsProvider.error != null && newsProvider.articles.isEmpty) {
              return ErrorView(
                message: newsProvider.error!,
                onRetry: _fetchNews,
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Category Chips
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return CategoryChip(
                          label: category,
                          isSelected: newsProvider.selectedCategory == category,
                          onTap: () {
                            final settings = context.read<SettingsProvider>();
                            newsProvider.fetchHeadlines(
                              country: settings.country,
                              language: settings.language,
                              category: category,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                // Featured Article
                if (newsProvider.articles.isNotEmpty)
                  SliverToBoxAdapter(
                    child: FeaturedArticleCard(
                      article: newsProvider.articles.first,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ArticleDetailScreen(
                              article: newsProvider.articles.first),
                        ),
                      ),
                    ),
                  ),

                // Section Header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SectionHeader(
                      title: 'Latest News',
                      actionLabel: 'See All',
                    ),
                  ),
                ),

                // Compact List
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Skip the first article as it's featured
                      if (index == 0) return const SizedBox.shrink();
                      final article = newsProvider.articles[index];
                      return CompactArticleTile(
                        article: article,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ArticleDetailScreen(article: article),
                          ),
                        ),
                      );
                    },
                    childCount: newsProvider.articles.length,
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          },
        ),
      ),
    );
  }
}
