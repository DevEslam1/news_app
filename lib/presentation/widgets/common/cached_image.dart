import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CachedImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.surfaceTier2 : Colors.grey[200];
    final iconColor = isDark ? AppColors.grey : Colors.grey[500];

    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: bgColor,
        child: Icon(Icons.broken_image_outlined, color: iconColor),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: bgColor,
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: bgColor,
        child: Icon(Icons.broken_image_outlined, color: iconColor),
      ),
    );
  }
}
