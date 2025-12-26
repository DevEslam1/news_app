# News App

A simple news application built with Flutter that displays the latest headlines from various categories.

## Features

*   Browse news headlines by category.
*   View news from different countries.
*   Search for articles.
*   Change country and language for the news.
*   Pull to refresh for the latest news.
*   Shimmer loading effect while fetching data.
*   Transparent app bar for a better reading experience.
*   Dynamic app bar title: includes an app icon and 'NewsCloud' text, where 'News' adapts to the theme and 'Cloud' is always orange.
*   Dark mode support, configurable in settings and now the default.
*   Offline snackbar changed to red for better visibility.

## Screenshots

| Light Theme                                     | Dark Theme                                    |
| ----------------------------------------------- | --------------------------------------------- |
|  ![Uploading Simulator Screenshot - iPhone 16e - 2025-12-26 at 16.27.18.png…]()
|  ![Uploading Simulator Screenshot - iPhone 16e - 2025-12-26 at 16.27.09.png…]() |

## Dependencies

*   [dio](https://pub.dev/packages/dio): A powerful HTTP client for Dart, which is used to make requests to the News API.
*   [shimmer](https://pub.dev/packages/shimmer): A Flutter package that provides an easy way to add a shimmer effect to your widgets.
*   [cached_network_image](https://pub.dev/packages/cached_network_image): A Flutter library to load and cache network images.
*   [shared_preferences](https://pub.dev/packages/shared_preferences): A Flutter plugin for reading and writing simple key-value pairs.
*   [provider](https://pub.dev/packages/provider): A wrapper around `InheritedWidget` to make them easier to use and more reusable.
*   [flutter_lints](https://pub.dev/packages/flutter_lints): A package that contains a set of recommended lints to encourage good coding practices.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   A News API key: [https://newsapi.org/](https://newsapi.org/)

### Installation

1.  Clone the repo
    ```sh
    git clone https://github.com/DevEslam1/news_app.git
    ```
2.  Install packages
    ```sh
    flutter pub get
    ```
3.  Add your API key in `lib/services/news_service.dart`
    ```dart
    final String _apiKey = 'YOUR_API_KEY';
    ```
4.  Run the app
    ```sh
    flutter run
    ```


