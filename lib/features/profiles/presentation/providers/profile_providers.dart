import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/profile_model.dart';
import '../../data/repositories/profile_repository.dart';

/// Provider for the ProfileRepository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

/// Fetches profiles from network
final profilesFutureProvider = FutureProvider<List<Profile>>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.fetchProfiles();
});

/// Holds the current active search query text
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider that filters profiles based on case-insensitive match on name or city
final filteredProfilesProvider = Provider<AsyncValue<List<Profile>>>((ref) {
  final profilesAsync = ref.watch(profilesFutureProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return profilesAsync.whenData((profiles) {
    if (query.isEmpty) {
      return profiles;
    }
    return profiles.where((profile) {
      final nameMatches = profile.name.toLowerCase().contains(query);
      final cityMatches = profile.city.toLowerCase().contains(query);
      return nameMatches || cityMatches;
    }).toList();
  });
});
