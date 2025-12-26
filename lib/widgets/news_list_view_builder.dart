import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/utils/settings_provider.dart';
import 'package:news_app/widgets/error_message.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';
import 'news_list_view.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;
  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  Future<List<ArticleModel>>? future;

  @override
  void initState() {
    super.initState();
    _updateFuture();
  }

  @override
  void didUpdateWidget(NewsListViewBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _updateFuture();
    }
  }

  void _updateFuture() {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    future = NewsService(Dio()).getTopHeadlines(
        category: widget.category,
        country: settings.country,
        language: settings.language);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        // We need to refetch the news when the country changes.
        // A simple way to do this is to update the future in the builder.
        // This is not the most efficient way, but it works for this case.
        _updateFuture();
        return FutureBuilder<List<ArticleModel>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                          'No articles available. Check your internet connection or try again later.'),
                    ),
                  );
                }
                return NewsListView(
                  articles: snapshot.data!,
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: ErrorMessage(errMessage: snapshot.error.toString()),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            });
      },
    );
  }
}
