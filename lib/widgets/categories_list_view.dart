import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';

import 'category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  final List<CategoryModel> categories = const [
    const CategoryModel(
      image: 'assets/business.avif',
      categoryName: 'Business',
    ),
    const CategoryModel(
      image: 'assets/entertaiment.avif',
      categoryName: 'Entertainment',
    ),
    const CategoryModel(
      image: 'assets/health.avif',
      categoryName: 'Health',
    ),
    const CategoryModel(
      image: 'assets/science.avif',
      categoryName: 'Science',
    ),
    const CategoryModel(
      image: 'assets/technology.jpeg',
      categoryName: 'Technology',
    ),
    const CategoryModel(
      image: 'assets/sports.avif',
      categoryName: 'Sports',
    ),
    const CategoryModel(
      image: 'assets/general.avif',
      categoryName: 'General',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categories[index],
            );
          }),
    );
  }
}
