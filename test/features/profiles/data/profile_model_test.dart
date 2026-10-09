import 'package:flutter_test/flutter_test.dart';
import 'package:nada_app/features/profiles/data/models/profile_model.dart';

void main() {
  group('Profile Model Unit Tests', () {
    test('parses full standard profile json correctly', () {
      final json = {
        'id': 1,
        'name': 'Aarav Patel',
        'age': 29,
        'gender': 'M',
        'city': 'Ahmedabad',
        'community': 'Gujarati Patel',
        'profession': 'Software Architect',
        'education': 'B.Tech in Computer Engineering',
        'degree': 1,
        'connected_through': 'Pooja Patel',
        'about': 'Passionate about distributed systems.',
      };

      final profile = Profile.fromJson(json);

      expect(profile.id, 1);
      expect(profile.name, 'Aarav Patel');
      expect(profile.age, 29);
      expect(profile.gender, 'M');
      expect(profile.city, 'Ahmedabad');
      expect(profile.community, 'Gujarati Patel');
      expect(profile.profession, 'Software Architect');
      expect(profile.education, 'B.Tech in Computer Engineering');
      expect(profile.degree, 1);
      expect(profile.connectedThrough, 'Pooja Patel');
      expect(profile.about, 'Passionate about distributed systems.');
      expect(profile.hasConnection, isTrue);
      expect(profile.connectionDisplayText, 'Pooja Patel');
      expect(profile.genderDisplay, 'Male');
      expect(profile.degreeDisplay, '1st degree connection');
      expect(profile.initials, 'AP');
    });

    test('handles edge cases: missing keys and null attributes', () {
      // Dev Chaudhary edge case (education key absent) & null values
      final json = {
        'id': 6,
        'name': 'Dev Chaudhary',
        'age': 32,
        'gender': 'M',
        'city': 'Jaipur',
        'community': 'Jaat',
        'profession': 'Civil Contractor',
        // 'education' key is completely omitted
        'degree': null,
        'connected_through': null,
        'about': null,
      };

      final profile = Profile.fromJson(json);

      expect(profile.id, 6);
      expect(profile.name, 'Dev Chaudhary');
      expect(profile.education, isNull);
      expect(profile.degree, isNull);
      expect(profile.connectedThrough, isNull);
      expect(profile.about, isNull);
      expect(profile.hasConnection, isFalse);
      expect(profile.connectionDisplayText, 'No connection yet');
      expect(profile.degreeDisplay, isNull);
      expect(profile.initials, 'DC');
    });

    test('handles unicode Hindi (Devanagari) script seamlessly', () {
      final json = {
        'id': 16,
        'name': 'Meera Joshi',
        'age': 27,
        'gender': 'F',
        'city': 'Varanasi',
        'connected_through': 'आपके मौसा जी के बैंक के सहकर्मी।',
        'about': 'शास्त्रीय संगीत और कथक नृत्यांगना।',
      };

      final profile = Profile.fromJson(json);

      expect(profile.id, 16);
      expect(profile.name, 'Meera Joshi');
      expect(profile.genderDisplay, 'Female');
      expect(profile.connectedThrough, 'आपके मौसा जी के बैंक के सहकर्मी।');
      expect(profile.about, 'शास्त्रीय संगीत और कथक नृत्यांगना।');
      expect(profile.hasConnection, isTrue);
    });

    test('correctly computes initials for long or single names', () {
      final singleName = Profile(
        id: 99,
        name: 'Kabir',
        age: 25,
        gender: 'M',
        city: 'Pune',
      );
      expect(singleName.initials, 'K');

      final longName = Profile(
        id: 100,
        name: 'Rajeshwari Nandini Mishra Chaturvedi',
        age: 26,
        gender: 'F',
        city: 'Lucknow',
      );
      expect(longName.initials, 'RC');
    });
  });
}
