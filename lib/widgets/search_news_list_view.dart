import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

import 'news_tile.dart';

class SearchNewsListView extends StatelessWidget {
  final List<ArticleModel> articles;

  const SearchNewsListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: NewsTile(
            articleModel: articles[index],
          ),
        );
      },
    );
  }
}
