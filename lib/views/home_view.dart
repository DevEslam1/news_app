import 'package:flutter/material.dart';
import 'package:news_app/utils/theme_provider.dart';
import 'package:news_app/widgets/categories_list_view.dart';

import '../widgets/news_list_view_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Builder(builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('News',
                  style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      color: Theme.of(context).appBarTheme.foregroundColor)),
              const Text(
                'Cloud',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              isDarkMode.value = !isDarkMode.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkMode,
              builder: (context, isDark, child) {
                return Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                );
              },
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: CategoriesListView()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            NewsListViewBuilder(
              category: 'general',
            ),
          ],
        ),
      ),
    );
  }
}
