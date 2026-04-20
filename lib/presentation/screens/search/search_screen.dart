import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/search_provider.dart';
import '../../providers/settings_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/article_cards/compact_article_tile.dart';
import '../../widgets/common/empty_state_view.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/shimmer_loading.dart';
import '../article_detail/article_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() {
    if (_controller.text.isNotEmpty) {
      final settings = context.read<SettingsProvider>();
      context.read<SearchProvider>().performSearch(
            query: _controller.text,
            language: settings.language,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _onSearch(),
              decoration: InputDecoration(
                hintText: 'Search for articles, topics...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    _controller.clear();
                    context.read<SearchProvider>().clearSearch();
                  },
                ),
              ),
            ),
          ),

          // Results / Recent / Empty
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                if (searchProvider.isLoading) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) => const CompactArticleShimmer(),
                  );
                }

                if (searchProvider.searchResults.isEmpty) {
                  if (searchProvider.recentSearches.isNotEmpty && _controller.text.isEmpty) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const SectionHeader(title: 'Recent Searches'),
                        Wrap(
                          spacing: 8,
                          children: searchProvider.recentSearches.map((query) {
                            return ActionChip(
                              label: Text(query),
                              backgroundColor: AppColors.surfaceTier2,
                              onPressed: () {
                                _controller.text = query;
                                _onSearch();
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }
                  return const EmptyStateView(
                    message: 'Find latest news from around the world',
                    icon: Icons.search_off_rounded,
                  );
                }

                return ListView.builder(
                  itemCount: searchProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final article = searchProvider.searchResults[index];
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
          ),
        ],
      ),
    );
  }
}
