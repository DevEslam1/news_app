import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyStateView({
    super.key,
    required this.message,
    this.icon = Icons.article_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey.withValues(alpha: 0.5),
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
