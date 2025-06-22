# News App UI - Flutter

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

A modern news application with beautiful UI built with Flutter. Features category-based news browsing, smooth animations, and responsive design.

## Features ✨
- **Category Navigation**: Browse news by categories (Business, Entertainment, Health, Science, etc.)
- **Top Headlines**: View trending news articles with images and descriptions
- **Responsive Layout**: Adapts to different screen sizes
- **Smooth Animations**: Physics-based scrolling and transition effects
- **Clean Architecture**: Well-organized code with clear separation of concerns
- **API Integration**: Fetches real-time news data from NewsAPI

## Project Structure 🗂️
```plaintext
lib/
├── models/
│   ├── article_model.dart
│   └── category_model.dart
├── services/
│   └── news_service.dart
├── views/
│   ├── home_view.dart
│   └── category_view.dart
├── widgets/
│   ├── categories_list_view.dart
│   ├── category_card.dart
│   ├── news_list_view.dart
│   ├── news_list_view_builder.dart
│   └── news_tile.dart
└── main.dart
