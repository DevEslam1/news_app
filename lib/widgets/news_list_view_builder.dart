import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app_ui_setup/models/article_model.dart';
import 'package:news_app_ui_setup/widgets/shimmer_list_view.dart';

import '../services/news_service.dart';
import 'news_list_view.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  late Future<List<ArticleModel>> future;

  @override
  void initState() {
    super.initState();
    future = NewsService(Dio()).getTopHeadlines(category: widget.category);
  }

  Future<void> _refresh() async {
    future = NewsService(Dio()).getTopHeadlines(category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<ArticleModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                NewsListView(
                  articles: snapshot.data!,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Text('oops was an error, try later'),
                  ),
                ),
              ],
            );
          } else {
            return const CustomScrollView(
              slivers: [
                ShimmerListView(),
              ],
            );
          }
        },
      ),
    );
  }
}
