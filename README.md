# News App

A simple news application built with Flutter that displays the latest headlines from various categories.

## Features

*   Browse news headlines by category.
*   View news from different countries.
*   Pull to refresh for the latest news.
*   Shimmer loading effect while fetching data.
*   Transparent app bar for a better reading experience.
*   Dark mode support.

## Screenshots

| Light Theme                                     | Dark Theme                                    |
| ----------------------------------------------- | --------------------------------------------- |
| ![Light Theme Screenshot](screenshots/light.png) | ![Dark Theme Screenshot](screenshots/dark.png) |

## Dependencies

*   [dio](https://pub.dev/packages/dio): A powerful HTTP client for Dart, which is used to make requests to the News API.
*   [shimmer](https://pub.dev/packages/shimmer): A Flutter package that provides an easy way to add a shimmer effect to your widgets.
*   [cached_network_image](https://pub.dev/packages/cached_network_image): A Flutter library to load and cache network images.
*   [flutter_lints](https://pub.dev/packages/flutter_lints): A package that contains a set of recommended lints to encourage good coding practices.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   A News API key: [https://newsapi.org/](https://newsapi.org/)

### Installation

1.  Clone the repo
    ```sh
    git clone https://github.com/your_username_/news_app.git
    ```
2.  Install packages
    ```sh
    flutter pub get
    ```
3.  Add your API key in `lib/services/news_service.dart`
    ```dart
    const String apiKey = 'YOUR_API_KEY';
    ```
4.  Run the app
    ```sh
    flutter run
    ```
