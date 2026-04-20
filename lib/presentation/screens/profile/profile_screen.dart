import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<String> _countries = const [
    'ae',
    'ar',
    'at',
    'au',
    'be',
    'bg',
    'br',
    'ca',
    'ch',
    'cn',
    'co',
    'cu',
    'cz',
    'de',
    'eg',
    'fr',
    'gb',
    'gr',
    'hk',
    'hu',
    'id',
    'ie',
    'il',
    'in',
    'it',
    'jp',
    'kr',
    'lt',
    'lv',
    'ma',
    'mx',
    'my',
    'ng',
    'nl',
    'no',
    'nz',
    'ph',
    'pl',
    'pt',
    'ro',
    'rs',
    'ru',
    'sa',
    'se',
    'sg',
    'si',
    'sk',
    'th',
    'tr',
    'tw',
    'ua',
    'us',
    've',
    'za'
  ];

  final List<String> _languages = const [
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'he',
    'it',
    'nl',
    'no',
    'pt',
    'ru',
    'sv',
    'ud',
    'zh'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).cardColor,
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.grey),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back!',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('News Enthusiast',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Subscription Card (Stitch Design Reference)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upgrade to Premium',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Get unlimited access to all exclusive articles.',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Upgrade'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Settings Section
                Text('SETTINGS', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 12),

                // Country Selector
                _buildSettingTile(
                  context: context,
                  icon: Icons.public_rounded,
                  title: 'Country',
                  trailing: DropdownButton<String>(
                    value: settings.country,
                    underline: const SizedBox(),
                    items: _countries
                        .map((c) => DropdownMenuItem(
                            value: c, child: Text(c.toUpperCase())))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) settings.setCountry(val);
                    },
                  ),
                ),

                // Language Selector
                _buildSettingTile(
                  context: context,
                  icon: Icons.language_rounded,
                  title: 'Language',
                  trailing: DropdownButton<String>(
                    value: settings.language,
                    underline: const SizedBox(),
                    items: _languages
                        .map((l) => DropdownMenuItem(
                            value: l, child: Text(l.toUpperCase())))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) settings.setLanguage(val);
                    },
                  ),
                ),

                // Dark Mode Toggle
                _buildSettingTile(
                  context: context,
                  icon: Icons.dark_mode_rounded,
                  title: 'Dark Mode',
                  trailing: Switch(
                    value: settings.isDarkMode,
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                    onChanged: (val) => settings.setDarkMode(val),
                  ),
                ),

                const SizedBox(height: 40),
                Text('APP INFO', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 12),
                _buildSettingTile(
                    context: context,
                    icon: Icons.info_outline_rounded,
                    title: 'Version',
                    trailing: const Text('2.0.0')),
                _buildSettingTile(
                    context: context,
                    icon: Icons.policy_outlined,
                    title: 'Privacy Policy',
                    trailing: const Icon(Icons.chevron_right_rounded)),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Log Out',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingTile(
      {required BuildContext context,
      required IconData icon,
      required String title,
      required Widget trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 16)),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}
