import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Empty state widget displayed when no profiles match search criteria.
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
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 32,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No profiles match',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              query.isNotEmpty
                  ? 'We couldn\'t find any profiles matching "$query". Try checking for typos or searching by city.'
                  : 'No profiles available at this moment.',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            if (query.isNotEmpty && onClearSearch != null) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onClearSearch,
                icon: const Icon(Icons.close_rounded, size: 16),
                label: const Text('Clear Search'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
