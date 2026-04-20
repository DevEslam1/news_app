import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/settings_provider.dart';
import '../main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _finishOnboarding(BuildContext context) {
    context.read<SettingsProvider>().completeOnboarding();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Image Section
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuD-a8hJcQp34ruUwjlHN4a8PWqq9AQTefg_YFWIqZBRosiAqOOPADK5fzOPDgANfWU68tV-pUVH7EpHfZH48d8NimoV3i-OIlfsOiCatsutlMelTe1PWhe9K_W8mGGz1-pIuPazrfjCeOlogbU3Z71qYojJLCP-zDyEWDE5ku_qwxtwdwbWdgPjMfBwLPbeQhDj_LCZsvzTubVnYpel3g_YBmxGv3Fj1ChNpOeAuuKGbrmldIr-fTr5eK7fe6rRyyTHrWiUixsqZg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  // Gradient Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white,
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Container
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A237E),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1A237E).withValues(alpha: 0.15),
                            blurRadius: 24,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      'Personalized\nNews',
                      style: GoogleFonts.publicSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                        letterSpacing: -1,
                        color: const Color(0xFF000666),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Description
                    Text(
                      'Discover stories curated specifically for your interests, delivered with editorial precision and depth.',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: const Color(0xFF454652),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip
                  TextButton(
                    onPressed: () => _finishOnboarding(context),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF454652),
                      textStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    child: const Text('SKIP'),
                  ),

                  // Progress Dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF000666),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8E8E8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8E8E8),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),

                  // Next Pill
                  ElevatedButton(
                    onPressed: () => _finishOnboarding(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF000666),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFF000666).withValues(alpha: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
