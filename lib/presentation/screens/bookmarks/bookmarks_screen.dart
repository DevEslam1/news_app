import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookmarks_provider.dart';
import '../../widgets/article_cards/bookmark_article_card.dart';
import '../../widgets/common/empty_state_view.dart';
import '../article_detail/article_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarksProvider>().fetchBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: Consumer<BookmarksProvider>(
        builder: (context, bookmarksProvider, child) {
          if (bookmarksProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (bookmarksProvider.bookmarkedArticles.isEmpty) {
            return const EmptyStateView(
              message: 'You haven\'t saved any articles yet',
              icon: Icons.bookmark_border_rounded,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            itemCount: bookmarksProvider.bookmarkedArticles.length,
            itemBuilder: (context, index) {
              final article = bookmarksProvider.bookmarkedArticles[index];
              return BookmarkArticleCard(
                article: article,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetailScreen(article: article),
                  ),
                ),
                onRemove: () => bookmarksProvider.toggleBookmark(article),
              );
            },
          );
        },
      ),
    );
  }
}
