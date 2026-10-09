import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../providers/profile_providers.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/profile_card.dart';
import '../widgets/search_bar_widget.dart';
import 'profile_detail_screen.dart';

/// Screen 1: Friendzy-inspired Profiles feed with live case-insensitive search
/// and dating app vector assets.
class ProfileListScreen extends ConsumerWidget {
  const ProfileListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProfilesAsync = ref.watch(filteredProfilesProvider);
    final activeQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.background,
        title: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                AppIcons.datingApp,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nada Profiles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.4,
                    ),
                  ),
                  filteredProfilesAsync.maybeWhen(
                    data: (profiles) => Text(
                      activeQuery.isEmpty
                          ? '${profiles.length} verified profiles'
                          : '${profiles.length} result${profiles.length == 1 ? '' : 's'} found',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          return ref.refresh(profilesFutureProvider.future);
        },
        child: Column(
          children: [
            // Top Search Bar Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: const SearchBarWidget(),
            ),

            // Profiles List / States View
            Expanded(
              child: filteredProfilesAsync.when(
                loading: () => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentLight,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.connectionHighlightBorder,
                            width: 1.5,
                          ),
                        ),
                        child: Image.asset(
                          AppIcons.romantic,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Finding profiles & connections...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
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
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
                    itemCount: profiles.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
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
