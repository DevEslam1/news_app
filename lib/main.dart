import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'presentation/providers/news_provider.dart';
import 'presentation/providers/search_provider.dart';
import 'presentation/providers/bookmarks_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const NewsvilleApp());
}

class NewsvilleApp extends StatelessWidget {
  const NewsvilleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<SettingsProvider>()),
        ChangeNotifierProvider(create: (_) => sl<NewsProvider>()),
        ChangeNotifierProvider(create: (_) => sl<SearchProvider>()),
        ChangeNotifierProvider(create: (_) => sl<BookmarksProvider>()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'NewsCloud',
            debugShowCheckedModeBanner: false,
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
