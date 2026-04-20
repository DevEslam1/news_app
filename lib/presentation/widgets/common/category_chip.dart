import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor
              : (isDark ? AppColors.surfaceTier2 : Colors.grey[200]!),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Text(
          label.substring(0, 1).toUpperCase() +
              label.substring(1).toLowerCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.onSurfaceVariant : Colors.black54),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
