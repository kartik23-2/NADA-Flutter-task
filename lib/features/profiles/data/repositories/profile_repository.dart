import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_endpoints.dart';
import '../models/profile_model.dart';

class ProfileRepositoryException implements Exception {
  final String message;
  const ProfileRepositoryException(this.message);

  @override
  String toString() => message;
}

class ProfileRepository {
  final http.Client _client;
  final String _apiUrl;

  ProfileRepository({
    http.Client? client,
    String? apiUrl,
  })  : _client = client ?? http.Client(),
        _apiUrl = apiUrl ?? ApiEndpoints.profilesUrl;

  Future<List<Profile>> fetchProfiles() async {
    try {
      final response = await _client.get(Uri.parse(_apiUrl)).timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw const ProfileRepositoryException(
              'Connection timed out. Please check your network and try again.',
            ),
          );

      if (response.statusCode != 200) {
        throw ProfileRepositoryException(
          'Failed to load profiles (Server responded with HTTP ${response.statusCode}).',
        );
      }

      // Explicitly decode response bodyBytes as UTF-8 to correctly handle Unicode/Hindi characters
      final decodedString = utf8.decode(response.bodyBytes);
      final dynamic decodedJson = json.decode(decodedString);

      if (decodedJson is! Map<String, dynamic>) {
        throw const ProfileRepositoryException('Invalid response structure received.');
      }

      final profilesRaw = decodedJson['profiles'];
      if (profilesRaw is! List) {
        throw const ProfileRepositoryException('Profiles array is missing from response.');
      }

      return profilesRaw
          .whereType<Map<String, dynamic>>()
          .map((item) => Profile.fromJson(item))
          .toList();
    } on SocketException {
      throw const ProfileRepositoryException(
        'No internet connection. Please verify your network and retry.',
      );
    } on FormatException {
      throw const ProfileRepositoryException(
        'Failed to parse profiles data format.',
      );
    } on ProfileRepositoryException {
      rethrow;
    } catch (e) {
      throw ProfileRepositoryException(
        'An unexpected error occurred: ${e.toString()}',
      );
    }
  }
}
