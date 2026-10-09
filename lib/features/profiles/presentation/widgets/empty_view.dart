import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Friendzy-styled empty state widget displayed when search matches nothing.
class EmptyView extends StatelessWidget {
  final String query;
  final VoidCallback? onClearSearch;

  const EmptyView({
    super.key,
    required this.query,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.connectionHighlightBorder,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 38,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'No profiles match',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              query.isNotEmpty
                  ? 'We couldn\'t find any profiles matching "$query". Try searching with another name or city.'
                  : 'No verified profiles available right now.',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            if (query.isNotEmpty && onClearSearch != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onClearSearch,
                icon: const Icon(Icons.close_rounded, size: 16),
                label: const Text('Clear Search'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepPlum,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
