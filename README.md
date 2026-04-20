# NewsCloud 🗞️

**Newsville** (NewsCloud) is a premium, high-performance news application built with Flutter, showcasing **Clean Architecture** principles and a sophisticated **Editorial-Style Dark UI**.

The app provides a seamless reading experience with real-time headlines, offline caching, and a robust search engine, all while maintaining a highly maintainable and testable codebase.

---

## ✨ Features

- 🎭 **Premium Dark Experience**: A bespoke editorial design featuring vibrant primary accents, smooth gradients, and cinematic hero cards.
- 📂 **Smart Categorization**: Browse via curated topics including Business, Tech, Science, and more.
- 🔍 **Advanced Search**: Instant global news search with persistent local search history.
- 💾 **Offline Bookmarking**: Save articles to a local SQLite database for offline reading.
- 🌩️ **Real-time Synchronization**: Powered by NewsAPI with smart pull-to-refresh and interactive loading states.
- 🌍 **Localized Content**: Dynamic localization supporting multiple languages and target countries.

---

## 🏗️ Architecture: Clean & Scalable

The project has been refactored from the ground up using **Clean Architecture** and **SOLID** principles. This decoupling ensures the app remains scalable and easy to maintain.

### Layers:

1.  **Presentation Layer**:
    - Uses **Provider** for reactive state management.
    - Custom UI components designed for reusability.
    - Seamless navigation using a shell navigation pattern.
2.  **Domain Layer**:
    - Pure Dart entities and Use Cases.
    - Zero dependency on external frameworks (Framework Agnostic).
3.  **Data Layer**:
    - **Remote Source**: Integrated with **Dio** for robust networking.
    - **Local Source**: Powered by **sqflite** for persistent storage and **shared_preferences** for settings.
    - Mapper logic to keep Domain entities clean from API DTOs.

---

## 🛠️ Technical Stack

- **Framework**: [Flutter](https://flutter.dev/) (Channel Stable)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Networking**: [Dio](https://pub.dev/packages/dio) with custom Interceptors
- **Persistence**: [SQLite (sqflite)](https://pub.dev/packages/sqflite) & [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **Design Patterns**: Service Locator, Repository Pattern, Mapper Pattern
- **UI Essentials**: Cached Network Image, Google Fonts (Public Sans / Inter), Shimmer

---

## 📸 visual Showcase

|                                         Home Feed                                          |                                         Article Details                                         |                                          Categories                                          |
| :----------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------: |
| <img src="https://via.placeholder.com/250x500/0A0E21/FFFFFF?text=Home+Feed" width="250" /> | <img src="https://via.placeholder.com/250x500/0A0E21/FFFFFF?text=Article+Detail" width="250" /> | <img src="https://via.placeholder.com/250x500/0A0E21/FFFFFF?text=Topics+Grid" width="250" /> |

|                                            Search                                             |                                           Bookmarks                                            |                                          Profile                                          |
| :-------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------: |
| <img src="https://via.placeholder.com/250x500/0A0E21/FFFFFF?text=Search+Logic" width="250" /> | <img src="https://via.placeholder.com/250x500/0A0E21/FFFFFF?text=Local+Storage" width="250" /> | <img src="https://via.placeholder.com/250x500/0A0E21/FFFFFF?text=Settings" width="250" /> |

_(Note: Replace placeholders with actual screenshots from your running app for a professional look)_

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- News API Key from [newsapi.org](https://newsapi.org/)

### Setup

1. **Clone the project**:
   ```bash
   git clone https://github.com/DevEslam1/news_app.git
   cd news_app
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Configure API Key**:
   Navigate to `lib/core/constants/api_constants.dart` and add your key:
   ```dart
   static const String apiKey = 'YOUR_API_KEY';
   ```
4. **Run Application**:
   ```bash
   flutter run
   ```

---

## 👨‍💻 Developer

**Eslam** - Senior Flutter Developer

- [GitHub](https://github.com/DevEslam1)

---

> [!TIP]
> This project is a perfect demonstration of **Clean Architecture** in Flutter. Explore the `lib/` directory to see the layer separation in action!
