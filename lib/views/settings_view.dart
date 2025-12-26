import 'package:flutter/material.dart';
import 'package:news_app/utils/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  final List<String> _countries = const [
    'ae', 'ar', 'at', 'au', 'be', 'bg', 'br', 'ca', 'ch', 'cn', 'co', 'cu', 'cz', 'de', 'eg', 'fr', 'gb', 'gr', 'hk', 'hu', 'id', 'ie', 'il', 'in', 'it', 'jp', 'kr', 'lt', 'lv', 'ma', 'mx', 'my', 'ng', 'nl', 'no', 'nz', 'ph', 'pl', 'pt', 'ro', 'rs', 'ru', 'sa', 'se', 'sg', 'si', 'sk', 'th', 'tr', 'tw', 'ua', 'us', 've', 'za'
  ];

  final List<String> _languages = const [
    'ar', 'de', 'en', 'es', 'fr', 'he', 'it', 'nl', 'no', 'pt', 'ru', 'sv', 'ud', 'zh'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Country', style: Theme.of(context).textTheme.titleLarge),
                DropdownButton<String>(
                  value: settings.country,
                  isExpanded: true,
                  items: _countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      settings.setCountry(newValue);
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text('Language', style: Theme.of(context).textTheme.titleLarge),
                DropdownButton<String>(
                  value: settings.language,
                  isExpanded: true,
                  items: _languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      settings.setLanguage(newValue);
                    }
                  },
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: Text('Dark Mode', style: Theme.of(context).textTheme.titleLarge),
                  value: settings.isDarkMode,
                  onChanged: (bool value) {
                    settings.setDarkMode(value);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
