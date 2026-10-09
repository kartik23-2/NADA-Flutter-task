import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nada_app/core/theme/app_theme.dart';
import 'package:nada_app/features/profiles/data/models/profile_model.dart';
import 'package:nada_app/features/profiles/presentation/providers/profile_providers.dart';
import 'package:nada_app/features/profiles/presentation/screens/profile_detail_screen.dart';
import 'package:nada_app/features/profiles/presentation/screens/profile_list_screen.dart';
import 'package:nada_app/features/profiles/presentation/widgets/empty_view.dart';
import 'package:nada_app/features/profiles/presentation/widgets/error_view.dart';
import 'package:nada_app/features/profiles/presentation/widgets/profile_card.dart';

final testProfiles = [
  const Profile(
    id: 1,
    name: 'Aarav Patel',
    age: 29,
    gender: 'M',
    city: 'Ahmedabad',
    profession: 'Software Architect',
    degree: 1,
    connectedThrough: 'Pooja Patel',
  ),
  const Profile(
    id: 2,
    name: 'Ananya Sharma',
    age: 27,
    gender: 'F',
    city: 'Bengaluru',
    profession: 'Product Designer',
    degree: 2,
    connectedThrough: 'Rohan Sharma',
  ),
  const Profile(
    id: 3,
    name: 'Vikram Malhotra',
    age: 31,
    gender: 'M',
    city: 'Mumbai',
    profession: 'Investment Banker',
    degree: null,
    connectedThrough: null,
  ),
];

Widget createTestWidget({
  List<Profile>? profiles,
  Object? error,
}) {
  return ProviderScope(
    overrides: [
      profilesFutureProvider.overrideWith((ref) async {
        if (error != null) {
          throw error;
        }
        return profiles ?? testProfiles;
      }),
    ],
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      home: const ProfileListScreen(),
    ),
  );
}

void main() {
  testWidgets('renders list of profiles and connection badges properly',
      (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Verify search bar and profiles are displayed
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ProfileCard), findsNWidgets(3));
    expect(find.text('Aarav Patel'), findsOneWidget);
    expect(find.text('Ananya Sharma'), findsOneWidget);
    expect(find.text('Vikram Malhotra'), findsOneWidget);

    // Verify connection highlights and empty connection indicator
    expect(find.text('Pooja Patel'), findsOneWidget);
    expect(find.text('Rohan Sharma'), findsOneWidget);
    expect(find.text('No connection yet'), findsOneWidget);
  });

  testWidgets('filters profiles reactively by name (case-insensitive)',
      (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Search "ananya" in lowercase
    await tester.enterText(find.byType(TextField), 'ananya');
    await tester.pumpAndSettle();

    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.text('Ananya Sharma'), findsOneWidget);
    expect(find.text('Aarav Patel'), findsNothing);
    expect(find.text('Vikram Malhotra'), findsNothing);
  });

  testWidgets('filters profiles reactively by city (case-insensitive)',
      (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Search by city "mumbai"
    await tester.enterText(find.byType(TextField), 'mumbai');
    await tester.pumpAndSettle();

    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.text('Vikram Malhotra'), findsOneWidget);
    expect(find.text('Aarav Patel'), findsNothing);
  });

  testWidgets('shows EmptyView with "No profiles match" when query matches nothing',
      (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'NonExistentCityOrPerson');
    await tester.pumpAndSettle();

    expect(find.byType(ProfileCard), findsNothing);
    expect(find.byType(EmptyView), findsOneWidget);
    expect(find.text('No profiles match'), findsOneWidget);
  });

  testWidgets('renders ErrorView with retry button when error occurs',
      (tester) async {
    await tester.pumpWidget(
      createTestWidget(error: Exception('Failed to fetch profiles')),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text('Unable to Load Profiles'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });

  testWidgets('navigates to ProfileDetailScreen when tapping a ProfileCard',
      (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Tap the first card
    await tester.tap(find.text('Aarav Patel'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileDetailScreen), findsOneWidget);
    expect(find.text('Profile Details'), findsOneWidget);
    expect(find.text('CONNECTION PATHWAY'), findsOneWidget);
  });
}
