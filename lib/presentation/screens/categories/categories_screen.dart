import 'package:flutter/material.dart';
import 'category_feed_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, String>> _categories = const [
    {'name': 'Business', 'image': 'assets/business.avif'},
    {'name': 'Entertainment', 'image': 'assets/entertaiment.avif'},
    {'name': 'Health', 'image': 'assets/health.avif'},
    {'name': 'Science', 'image': 'assets/science.avif'},
    {'name': 'Technology', 'image': 'assets/technology.jpeg'},
    {'name': 'Sports', 'image': 'assets/sports.avif'},
    {'name': 'General', 'image': 'assets/general.avif'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryFeedScreen(category: category['name']!),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(category['image']!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  category['name']!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
