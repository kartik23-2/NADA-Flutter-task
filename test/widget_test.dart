import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nada_app/app.dart';
import 'package:nada_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:nada_app/features/profiles/presentation/screens/profile_list_screen.dart';

void main() {
  testWidgets('NadaApp displays SplashScreen and navigates to ProfileListScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: NadaApp(),
      ),
    );

    // Initial state: SplashScreen is visible
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Connections That Matter'), findsOneWidget);

    // Advance timer past splash duration
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));

    // After transition: ProfileListScreen is visible
    expect(find.byType(ProfileListScreen), findsOneWidget);
  });
}
