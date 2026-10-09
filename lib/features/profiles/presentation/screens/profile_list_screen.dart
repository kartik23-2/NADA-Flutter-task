import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/profile_providers.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/profile_card.dart';
import '../widgets/search_bar_widget.dart';
import 'profile_detail_screen.dart';

/// Screen 1: Profiles feed with live case-insensitive search and mutual connection highlights.
class ProfileListScreen extends ConsumerWidget {
  const ProfileListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProfilesAsync = ref.watch(filteredProfilesProvider);
    final activeQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nada Profiles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            filteredProfilesAsync.maybeWhen(
              data: (profiles) => Text(
                activeQuery.isEmpty
                    ? '${profiles.length} verified profiles'
                    : '${profiles.length} result${profiles.length == 1 ? '' : 's'} found',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          // Re-fetch profiles on pull-to-refresh
          return ref.refresh(profilesFutureProvider.future);
        },
        child: Column(
          children: [
            // Top Search Bar Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: const SearchBarWidget(),
            ),

            // Profiles List / States View
            Expanded(
              child: filteredProfilesAsync.when(
                loading: () => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Finding profiles & connections...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                error: (error, _) => ErrorView(
                  message: error.toString(),
                  onRetry: () => ref.refresh(profilesFutureProvider),
                ),
                data: (profiles) {
                  if (profiles.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: EmptyView(
                        query: activeQuery,
                        onClearSearch: () {
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: profiles.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final profile = profiles[index];
                      return ProfileCard(
                        profile: profile,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProfileDetailScreen(
                                profile: profile,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
