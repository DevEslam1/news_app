import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_colors.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.surfaceTier2 : Colors.grey[300]!,
      highlightColor: isDark ? AppColors.surfaceTier3 : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class CompactArticleShimmer extends StatelessWidget {
  const CompactArticleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const ShimmerLoading(width: 100, height: 100, borderRadius: 12),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerLoading(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                const ShimmerLoading(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                ShimmerLoading(width: MediaQuery.of(context).size.width * 0.4, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedArticleShimmer extends StatelessWidget {
  const FeaturedArticleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(width: double.infinity, height: 200, borderRadius: 16),
          SizedBox(height: 12),
          ShimmerLoading(width: 100, height: 16),
          SizedBox(height: 8),
          ShimmerLoading(width: double.infinity, height: 24),
          SizedBox(height: 8),
          ShimmerLoading(width: double.infinity, height: 24),
        ],
      ),
    );
  }
}
